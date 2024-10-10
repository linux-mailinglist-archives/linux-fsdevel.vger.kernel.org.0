Return-Path: <linux-fsdevel+bounces-31507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E00997B3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 05:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693921F232C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 03:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F33C19309C;
	Thu, 10 Oct 2024 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="cinOGTlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888018DF84
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530821; cv=none; b=Wgm4GM9/00ZUPvlRpMmk/cRdW5xRSQ2qx8ZMqLDGY1B6F6beR9d+j2e+DSjUGz5rNTx5w5gvhdo4CdOKYlWGJVg9LJJrMNdH3E3PVnAEp9L9RtgLRSHYlUYJVCOJqgtS8jCB572t5mzBWO8mLwyhkFGwK14vtTkEImLktRhnN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530821; c=relaxed/simple;
	bh=UVQpwLVau/arCRg+UIUQe+wNoqj/iKEwa0exLFVD3tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDQoiB1GiK/eJ9OGsFcQSNnzCnlG4TgKb8Fbdn8yMVb27wa9SIoTp/Gd+mFGTO3AazfYdFuKWzhTFqtF4Fq0oRm7tX9Sp9vkb3KALp3Lkn6B4x14b2a6QksMrLJ2W8jBXDT24sIOS3QLzZYfLWTB0Tl67DhrUnzbdSsGGK8BZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=cinOGTlS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c46c2bf490so228995a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728530816; x=1729135616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBS8JqacgTJusHIYvpWe9mJdsd0pZO5EBVeF/1faiJE=;
        b=cinOGTlS+Caz7/pSGACKgYXp/u2KBS83pO6yu0K00kuqD8Zc94xXLxCwxRoFlJgqK4
         p+UBgL7r0Piug13lyBr8InNNqkKdi1cfFNcdlsWVkmtdub3hL4PiOsamogIernp/zmY3
         0IohYS+edCVMFVqd3ry6Ma+58T4e+clGwwGjQAY2TgMX+CatVcJvzq7cUuGem7hHojft
         8EJQhlpgGk/nwnQlqW7JmUbZCGcJ1cFxhvoTFp5fG7SvaVHP/WRgpIs+rcihc5nKnYlr
         7F+900fctv3VZaMt51siHX32lwqwcEq0eOdeOfxlRxK3ko07k88E4ESdoIzdgZRXgTE/
         qUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728530816; x=1729135616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBS8JqacgTJusHIYvpWe9mJdsd0pZO5EBVeF/1faiJE=;
        b=uYV+4gx9zizsC+xVUrrt1ORkxjcDa7JoQn4g6PLDP7SB1Jw9gQzUJgFDpI0aSrs+Fd
         Mz+xMdXd+mQ5CwwILE9/m8OIntSysrqN8Id1usR3eFpfQ1VgLW1W8sxx3GTc61pmC9Nz
         S/I5hyL5yFEcHEk5Q46bCKqshWNzOLYuifiAFnfLvpOxUjtTuE8dJcogATUQSNzCS4uL
         E3LSXtb2TmJ9Eesyy7T0dARmMQL5dwm7HM4qOq8aJ/gnnQSGgenKfk8LkhjISIsav9nP
         gprrTcFhh7NfsPJwRk51w0/o6ULEN/DxsnWcwVZJjJ44LR0zRRi/urU4k6TPsXkvGQya
         ubKA==
X-Forwarded-Encrypted: i=1; AJvYcCUDePPj36FHtQp/dnFHgR6DzKRgsa/DYTxXo6rZISFw/N5Pbf7yEBCZ8JKVu3xwwYj2Ky2GpCZ57LLapTSD@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuKDf2/9oRomFqjCeMB3VpR1pb1NysQxQM89QB1XtYTcjixcQ
	+3hGM+7N7WLaE5UPQslTm0DTI+QPwa+2Vq2RnSV5+4bquFIh2EawZWPy2kYFh3VjJqDmUrATC9u
	63iomHLuH41+PTxzYbu85enKk+BOmJF/I+yufboODsENNEYHN2mSJMcVk
X-Google-Smtp-Source: AGHT+IElv3jiZuNqPx5fdmdxSlpoVa0Q8karhVN65OPF7QDuCpOS35zdKNnZrlzGF5zq1QCy/a86F1ShHUHR/om3h30=
X-Received: by 2002:a05:6402:40cf:b0:5c5:b6ee:e95b with SMTP id
 4fb4d7f45d1cf-5c91d550a90mr5979696a12.8.1728530816554; Wed, 09 Oct 2024
 20:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-2-yizhou.tang@shopee.com> <20241003130127.45kinxoh77xm5qfb@quack3>
 <CACuPKxmwZgNx242x5HgTUCpu6v6QC3XtFY2ZDOE-mcu=ARK=Ag@mail.gmail.com>
 <20241007162311.77r5rra2tdhzszek@quack3> <CACuPKx=-wmNOHbHFEqYEwnw6X7uzaZ+JU7pHqG+FCsAgKjePnQ@mail.gmail.com>
 <20241009145505.5ol3mushw6uqjefc@quack3>
In-Reply-To: <20241009145505.5ol3mushw6uqjefc@quack3>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Thu, 10 Oct 2024 11:26:45 +0800
Message-ID: <CACuPKxnLNK144yS9=PzStbPk_q0vSEj5fE1Aveg5Ourg088Lag@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL
To: Jan Kara <jack@suse.cz>
Cc: willy@infradead.org, akpm@linux-foundation.org, chandan.babu@oracle.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:55=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 08-10-24 22:14:16, Tang Yizhou wrote:
> > On Tue, Oct 8, 2024 at 12:23=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sun 06-10-24 20:41:11, Tang Yizhou wrote:
> > > > On Thu, Oct 3, 2024 at 9:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > >
> > > > > On Wed 02-10-24 21:00:02, Tang Yizhou wrote:
> > > > > > From: Tang Yizhou <yizhou.tang@shopee.com>
> > > > > >
> > > > > > The name of the BANDWIDTH_INTERVAL macro is misleading, as it i=
s not
> > > > > > only used in the bandwidth update functions wb_update_bandwidth=
() and
> > > > > > __wb_update_bandwidth(), but also in the dirty limit update fun=
ction
> > > > > > domain_update_dirty_limit().
> > > > > >
> > > > > > Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL to make things cle=
ar.
> > > > > >
> > > > > > This patche doesn't introduce any behavioral changes.
> > > > > >
> > > > > > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > > > >
> > > > > Umm, I agree BANDWIDTH_INTERVAL may be confusing but UPDATE_INTER=
VAL does
> > > > > not seem much better to be honest. I actually have hard time comi=
ng up with
> > > > > a more descriptive name so what if we settled on updating the com=
ment only
> > > > > instead of renaming to something not much better?
> > > > >
> > > > >                                                                 H=
onza
> > > >
> > > > Thank you for your review. I agree that UPDATE_INTERVAL is not a go=
od
> > > > name. How about
> > > > renaming it to BW_DIRTYLIMIT_INTERVAL?
> > >
> > > Maybe WB_STAT_INTERVAL? Because it is interval in which we maintain
> > > statistics about writeback behavior.
> > >
> >
> > I don't think this is a good name, as it suggests a relation to enum
> > wb_stat_item, but bandwidth and dirty limit are not in wb_stat_item.
>
> OK, so how about keeping BANDWIDTH_INTERVAL as is and adding
> DIRTY_LIMIT_INTERVAL with the same value? There's nothing which would
> strictly tie them to the same value.
>

Good idea, but this patch has already been merged. If there is any
writeback-related code that needs to be modified next time, I will
update this part as well.

Yi

>                                                                 Honza
>
> > > > > > ---
> > > > > >  mm/page-writeback.c | 16 ++++++++--------
> > > > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > > > > index fcd4c1439cb9..a848e7f0719d 100644
> > > > > > --- a/mm/page-writeback.c
> > > > > > +++ b/mm/page-writeback.c
> > > > > > @@ -54,9 +54,9 @@
> > > > > >  #define DIRTY_POLL_THRESH    (128 >> (PAGE_SHIFT - 10))
> > > > > >
> > > > > >  /*
> > > > > > - * Estimate write bandwidth at 200ms intervals.
> > > > > > + * Estimate write bandwidth or update dirty limit at 200ms int=
ervals.
> > > > > >   */
> > > > > > -#define BANDWIDTH_INTERVAL   max(HZ/5, 1)
> > > > > > +#define UPDATE_INTERVAL              max(HZ/5, 1)
> > > > > >
> > > > > >  #define RATELIMIT_CALC_SHIFT 10
> > > > > >
> > > > > > @@ -1331,11 +1331,11 @@ static void domain_update_dirty_limit(s=
truct dirty_throttle_control *dtc,
> > > > > >       /*
> > > > > >        * check locklessly first to optimize away locking for th=
e most time
> > > > > >        */
> > > > > > -     if (time_before(now, dom->dirty_limit_tstamp + BANDWIDTH_=
INTERVAL))
> > > > > > +     if (time_before(now, dom->dirty_limit_tstamp + UPDATE_INT=
ERVAL))
> > > > > >               return;
> > > > > >
> > > > > >       spin_lock(&dom->lock);
> > > > > > -     if (time_after_eq(now, dom->dirty_limit_tstamp + BANDWIDT=
H_INTERVAL)) {
> > > > > > +     if (time_after_eq(now, dom->dirty_limit_tstamp + UPDATE_I=
NTERVAL)) {
> > > > > >               update_dirty_limit(dtc);
> > > > > >               dom->dirty_limit_tstamp =3D now;
> > > > > >       }
> > > > > > @@ -1928,7 +1928,7 @@ static int balance_dirty_pages(struct bdi=
_writeback *wb,
> > > > > >               wb->dirty_exceeded =3D gdtc->dirty_exceeded ||
> > > > > >                                    (mdtc && mdtc->dirty_exceede=
d);
> > > > > >               if (time_is_before_jiffies(READ_ONCE(wb->bw_time_=
stamp) +
> > > > > > -                                        BANDWIDTH_INTERVAL))
> > > > > > +                                        UPDATE_INTERVAL))
> > > > > >                       __wb_update_bandwidth(gdtc, mdtc, true);
> > > > > >
> > > > > >               /* throttle according to the chosen dtc */
> > > > > > @@ -2705,7 +2705,7 @@ int do_writepages(struct address_space *m=
apping, struct writeback_control *wbc)
> > > > > >        * writeback bandwidth is updated once in a while.
> > > > > >        */
> > > > > >       if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> > > > > > -                                BANDWIDTH_INTERVAL))
> > > > > > +                                UPDATE_INTERVAL))
> > > > > >               wb_update_bandwidth(wb);
> > > > > >       return ret;
> > > > > >  }
> > > > > > @@ -3057,14 +3057,14 @@ static void wb_inode_writeback_end(stru=
ct bdi_writeback *wb)
> > > > > >       atomic_dec(&wb->writeback_inodes);
> > > > > >       /*
> > > > > >        * Make sure estimate of writeback throughput gets update=
d after
> > > > > > -      * writeback completed. We delay the update by BANDWIDTH_=
INTERVAL
> > > > > > +      * writeback completed. We delay the update by UPDATE_INT=
ERVAL
> > > > > >        * (which is the interval other bandwidth updates use for=
 batching) so
> > > > > >        * that if multiple inodes end writeback at a similar tim=
e, they get
> > > > > >        * batched into one bandwidth update.
> > > > > >        */
> > > > > >       spin_lock_irqsave(&wb->work_lock, flags);
> > > > > >       if (test_bit(WB_registered, &wb->state))
> > > > > > -             queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWID=
TH_INTERVAL);
> > > > > > +             queue_delayed_work(bdi_wq, &wb->bw_dwork, UPDATE_=
INTERVAL);
> > > > > >       spin_unlock_irqrestore(&wb->work_lock, flags);
> > > > > >  }
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > > >
> > > > > --
> > > > > Jan Kara <jack@suse.com>
> > > > > SUSE Labs, CR
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

