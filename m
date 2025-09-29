Return-Path: <linux-fsdevel+bounces-63023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A084DBA8F84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C1C16B883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3B2FF664;
	Mon, 29 Sep 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YpGC4Dnb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6C2EF671
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144104; cv=none; b=lq9DbOpsyPpPqhjHH4rsdkryO3uvEsNlrnB5grRojxojZM3lnv1ploR/54makc7EwvCswhkGSeakMTbI/2XfHCexV4fwF5UwlVctyLqel0uHBOpiRnUF1740WrqhSyuGwEC2jdkpDnsBEG2Fnl+PGGuzaT/Qgv88J4Iz4PxaQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144104; c=relaxed/simple;
	bh=dBr0+uM+oBGc7F4T5g3s46PYXfGGAx7fz9yGZkSl77o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/I2Qs9yVFJnywBpM6v3zPtBhDWv3mwu5hXFavQFeNxKtPXFM97NPyLt4iF6I1IthkLD/eTY+IeQ3nWqM4a9SuEwGL281pWL82lUqmXv6Z0Eu5RutKPl7h5RBpc4V/X2DVMdmfqyANQLbcCYuxp0KzZJlzkEk4ZMc8NSH30AoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YpGC4Dnb; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6089a139396so4710204d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759144101; x=1759748901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHdk9n/dbsdHiY2GbqkVoyMnPe37kuuY1TZLcqs/Bm8=;
        b=YpGC4DnbqYb38jMn3heev8BEMBmahwQCpFO7z24o8ADeZkf77cgrNpX6G23Em0tRT7
         kkW4hLy/m/EywJv/b8K8ueFF3GzhwCbgt5EokbcQYd6fCC9yfu62Wx+scNwmiB026GFv
         mbRHkBZm1+Stt5vZtO7FbRXTSXS9NR0g95+1buhnl7YrHdtNgy1S50furpl4dX5M3nd9
         4iWhXR6Jorrri8FcUdChZbOkDXkYySopnJvvIemB4O8w0nd6mKpoqrJPgqoBs0UJnpwL
         JfpIabfj1foNDpdZIkkVSw6mrz4cJKf2u7bRxY5bxr7q7bXmXT7SiZabDDhiy2NZjoG8
         4QVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144101; x=1759748901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHdk9n/dbsdHiY2GbqkVoyMnPe37kuuY1TZLcqs/Bm8=;
        b=lg6PAuScb8ubUDVqQqUnP/fSr7UWXpjlJeVSuAOuELu41UxvCxjU0yguFIajarwIVF
         1YErtRalCZgc+n0vybAAjTWYBbUvYwB0wfN8PDQJAQ+hoQ1juP590SIFha4dgQWPc/Mx
         TiCIBqhMCB17YTeLym2W6FW2qyV64EZHhXhMv4RIOsnonX/MloebIehbG2j9ARPvMyfL
         BTx+4K15aXIpqWuYYkSShKnu3Y69STktX+0dITMndM4XXUvojkIDZA92tcxGms8ijLiy
         OL/k/9lRCEdPsIaiWuGGWpgoyPc3wY0Is0LXvpSDVy3uCwx9KoWvu6c4J4t8lWr2b8PW
         M7yA==
X-Gm-Message-State: AOJu0Yy5/5D+FUd3mSA7cQEJfBxocXAf3vKb3sC935TB/ABZlp3Cexka
	ec/VNDSkrj/hkmOcTT8efrlRNcLQj7iIfVo/DXhrDra0/jifAEGFycYk/GFzhTvl7L/4dHxuk0I
	+nqlZqQaerICCP0Es7cNsKCOqFcmXRdYJZLcg9uZQs41MxBOj9yRgkrY=
X-Gm-Gg: ASbGncsnk5vhZySveotFoGl1slAnuxyAafAJ0y8GhLOX/iL9RBwURnmaYoyBu+x9gxU
	yrGWIMYxNCQVueeOFYd0drPf0KtZIj2SyRzl+BPxzLEtRL1rbRdBOzzQY2KSbqk9NhDQ7w2d2+M
	dDOxsfuEIMGFadjhlWwNK3UPVk2Qq3vD8+WSXxoB7Q7gi50hUGspaC/At0HYVV9bt9UWf8lswDb
	4RxIn6athctHQB9ncEvsNnSzzBnfvqTJCAhVg==
X-Google-Smtp-Source: AGHT+IE5I9eh19vkNZmJKn2wf6TV+r9uvrC2Pak5ON72RmwuRxE8TstIKAO3rn35Ob4YtfGHGo0RsYddDcbQRrxc+a0=
X-Received: by 2002:a05:690e:1a44:b0:635:4ed0:571f with SMTP id
 956f58d0204a3-63b59afddadmr108278d50.23.1759144101167; Mon, 29 Sep 2025
 04:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929092304.245154-1-sunjunchao@bytedance.com> <oz7nuthlqf42jzaqnm7xzwxddxpb2a7tmkkziljtzz4e3rlctc@6jvdfvuyexru>
In-Reply-To: <oz7nuthlqf42jzaqnm7xzwxddxpb2a7tmkkziljtzz4e3rlctc@6jvdfvuyexru>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Mon, 29 Sep 2025 19:08:08 +0800
X-Gm-Features: AS18NWCDTpjbm5Tg3peRniPhBE4NZearthxy_WpnM2hyxrn1olVyfH-WN7nVY4M
Message-ID: <CAHSKhtec_hKLXiaVr+cwj+AyGACkf6EZw2u4NefpfDi1SK1wqQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] writeback: Wake up waiting tasks when
 finishing the writeback of a chunk.
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	mjguzik@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 6:21=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 29-09-25 17:23:03, Julian Sun wrote:
> > Writing back a large number of pages can take a lots of time.
> > This issue is exacerbated when the underlying device is slow or
> > subject to block layer rate limiting, which in turn triggers
> > unexpected hung task warnings.
> >
> > We can trigger a wake-up once a chunk has been written back and the
> > waiting time for writeback exceeds half of
> > sysctl_hung_task_timeout_secs.
> > This action allows the hung task detector to be aware of the writeback
> > progress, thereby eliminating these unexpected hung task warnings.
> >
> > This patch has passed the xfstests 'check -g quick' test based on ext4,
> > with no additional failures introduced.
> >
> > Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Reviewed-by: Jan Kara <jack@suse.cz>
>
> One question that appeared to me now below:
>
> > @@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_writeb=
ack_work *work)
> >               kfree(work);
> >       if (done) {
> >               wait_queue_head_t *waitq =3D done->waitq;
> > +             /* Report progress to inform the hung task detector of th=
e progress. */
> > +             bool force_wake =3D (jiffies - done->stamp) >
> > +                                sysctl_hung_task_timeout_secs * HZ / 2=
;
> >
> >               /* @done can't be accessed after the following dec */
> > -             if (atomic_dec_and_test(&done->cnt))
> > +             if (atomic_dec_and_test(&done->cnt) || force_wake)
> >                       wake_up_all(waitq);
> >       }
>
> Is this hunk actually useful for anything? Given how wb_completions work
> finish_writeback_work() gets called at the moment when we should be wakin=
g
> up waiters anyway so there's no point in messing with hung task detector =
in
> this place?

Ah.. Exactly, will remove it in next version:)
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

