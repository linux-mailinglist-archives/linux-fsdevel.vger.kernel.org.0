Return-Path: <linux-fsdevel+bounces-71018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F80CB0929
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 17:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF3D301E145
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52809322C7F;
	Tue,  9 Dec 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coEV+L7+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRLkmwoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C70619CD06
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765297828; cv=none; b=QWlg2pL9NIEsHXdci4gQ7F0P+OYHQAd3vw71jKRodMlqtFU33j+55fwrLvCFj7Di46z8RT8LH603T9DoNbLGs+d0zCY3jH3wfIRRenjSTqLwgsBGqGyat/audtmlVFX0BxkxlfjyuJXILSOvaArdAOLtnFIPcZe9Vj0k8nESKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765297828; c=relaxed/simple;
	bh=mWYXQv9kBrNWUl74rGf0IsoUatu+r7BguEoNRy4fn2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTn/kls+tMxg0GCUMrcOsTqwX/qzwcJiezkQ1oOFEkG5sNbBSgpJziDaAcPVVE/4cysU8eXaQAbi0HEgwbIjRHNiEWxHLGS0ALbk4PfqPRCePVmn0luvOJ++3/I9LKq5KjgktOpm0xLr18Mt5i2zKgFG/ulBd7Uq584+rKQNgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coEV+L7+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRLkmwoU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765297826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNJM+/a72hqLk7DeV1Es06nlikRv4U7OBPmPYucLgO8=;
	b=coEV+L7+uiGBdYa32/HPz0X9Sr5/G5Iihc7O3XE3w2w/1nXOzw7FIqtisd3Ne16Y4iXWwK
	hKf074P5WNkCSGqB6wvZtv01v0VpuWboif6zQ0KYx+aqZvz1DtRvkZ/R0xmx4yI3cQ5PVa
	wSrLZEc/YLZ5fmFJ1gI7EtZPw2Ypamo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-USvbxipSOwmt3z1gkWHtng-1; Tue, 09 Dec 2025 11:30:19 -0500
X-MC-Unique: USvbxipSOwmt3z1gkWHtng-1
X-Mimecast-MFC-AGG-ID: USvbxipSOwmt3z1gkWHtng_1765297818
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b763b24f223so493947966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765297818; x=1765902618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNJM+/a72hqLk7DeV1Es06nlikRv4U7OBPmPYucLgO8=;
        b=NRLkmwoU+2Bq86FsUSiIIS1++mP+v5PPP1/shYzMtQCNBpdQKgSl8J90Idnf7ffH2s
         g4dh66A8Jgi49aOyeoFLPk1r4ewDBYfMpDZuafhw9Ws51ikXzx7l7VO+5ERLzeXjHlkP
         uVgprzZy2PSN41BySpIYHwWKRLjOAtCXDTd5uQqwge/wOH0yUnd0NJ3YqgyyAt72g59/
         MiSzfNy4SMBDj4rIfnoOczY1VMLwcUoZVnurgV2wG6BdiLyM5+0x1FtfiqD90IF8xgn6
         XK/VvceAJL7VsjwKlBsYVU0vF1UZTLfHgwo2pr2V6AFYqqRrQ8a3LSr4BerjfVvv/x/p
         P8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765297818; x=1765902618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNJM+/a72hqLk7DeV1Es06nlikRv4U7OBPmPYucLgO8=;
        b=G/6bGpxEVTFRecfqhhkuldgBAgWkGdhNDMeGqpmyURmwBK1RBp9PtpofOfIi7NoT74
         zBOaVxJ3LJg0dycqGZNXZBq6eVeXVRsEje9S5nsxJpUAgGstBc44PzqkVv7TyV8JEzYK
         F84lWehPNxonBfHx4jgWTx2dJY0QZfyPMQYDw+6s0oHVU/ykgwlKYSQgRkqJagi9Eslq
         sY0EYrXan3xVIS0ofMG5bd8+7uRKxufWwNfXcbiPMbKJXs8N3jfSm28Nu611KbB92xJX
         K8WrkoDKAjsbPa4zWA2QYL1cW6rhAi3NtqDOqPkF/LRlTDuK9qxJuayy0OwrJKtdEMc3
         AqcA==
X-Forwarded-Encrypted: i=1; AJvYcCUA2lXYWIUwoKReve+Zo8rsVU+zyCnwoC5XqDx86QYzI+JYa/gWC2itWXQyxoG8tSQok50TFvZCYcX8uRBl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EqHpS9Ibv9ctbDYWS1wbrtXLqr1JgQYFKt4YAcYXsHlJ+si9
	722f26z9MFEV/Fvhy52GCZKBVQlhGmkFPyKLktRaQkLmwev8cHybceNBcy4DM/6I+21LDO2IINL
	eL1IL4arLsrHvYCPOR9WOZRr83hLmk/O86gaLaU6xHrdyODzPOHT4pNYsZ/fIR3eqqvbn8DKW32
	aeJbOaboQxAdtJbQN+fa1NC5aZqvVf0t0iuuu9bvB+
X-Gm-Gg: ASbGncsXutwBcaRPTJbbhfjPPA79jTdqHzeVSN7cyIq5hQTkq/V1bn0+gtXlYiCuuCo
	nAlxolTdCrmT8pTIxDnkSre3wR5PdWH6rQ1CZTNiSk7ekRS84p3XAJGjcp6uSpmSGBfy9gQ63Xb
	oeeyMb0BdnBbkkHlKHtFlcoTSJkzI336GDqnlFDOvS5T8S3LsbLufCPm1b6YzclJ6w1a1X9jvzG
	q9ufGiYa+rpBvZGAvI5iH3XpQ==
X-Received: by 2002:a05:6402:4403:b0:641:8a92:9334 with SMTP id 4fb4d7f45d1cf-64919c053d4mr10220495a12.6.1765297817722;
        Tue, 09 Dec 2025 08:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEYe1/azPwhTPDR1lNg0l3UtlDdHeyP1/DESgWycXo326VwpjCf65aQg4x1Kb3PycKZJZotXx8/0L9ZeCCS0g=
X-Received: by 2002:a05:6402:4403:b0:641:8a92:9334 with SMTP id
 4fb4d7f45d1cf-64919c053d4mr10220473a12.6.1765297817308; Tue, 09 Dec 2025
 08:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208193024.GA89444@frogsfrogsfrogs> <20251208201333.528909-1-dkarn@redhat.com>
 <enzq67rnekrh7gycgvgjc4g5ryt7qvuamaqj3ndpmns5svosa4@ozcepp4lpyls>
In-Reply-To: <enzq67rnekrh7gycgvgjc4g5ryt7qvuamaqj3ndpmns5svosa4@ozcepp4lpyls>
From: Deepak Karn <dkarn@redhat.com>
Date: Tue, 9 Dec 2025 22:00:04 +0530
X-Gm-Features: AQt7F2rJWEUXcr8667_MlIJYeyXqTFJ0Pdgiv1sRpUUWvmAIGLZSLhT1bs-X-6s
Message-ID: <CAO4qAqK-6jpiFXTdpoB-e144N=Ux0Hs+NOouM6cmVDzV8V-Dcw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent null-ptr-deref
To: Jan Kara <jack@suse.cz>
Cc: djwong@kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 4:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 09-12-25 01:43:33, Deepakkumar Karn wrote:
> > On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > > > drop_buffers() dereferences the buffer_head pointer returned by
> > > > folio_buffers() without checking for NULL. This leads to a null poi=
nter
> > > > dereference when called from try_to_free_buffers() on a folio with =
no
> > > > buffers attached. This happens when filemap_release_folio() is call=
ed on
> > > > a folio belonging to a mapping with AS_RELEASE_ALWAYS set but witho=
ut
> > > > release_folio address_space operation defined. In such case,
> >
> > > What user is that?  All the users of AS_RELEASE_ALWAYS in 6.18 appear=
 to
> > > supply a ->release_folio.  Is this some new thing in 6.19?
> >
> > AFS directories SET AS_RELEASE_ALWAYS but have not .release_folio.
>
> AFAICS AFS sets AS_RELEASE_ALWAYS only for symlinks but not for
> directories? Anyway I agree AFS symlinks will have AS_RELEASE_ALWAYS but =
no
> .release_folio callback. And this looks like a bug in AFS because AFAICT
> there's no point in setting AS_RELEASE_ALWAYS when you don't have
> .release_folio callback. Added relevant people to CC.
>
>                                                                 Honza

Thank you for your response Jan. As you suggested, the bug is in AFS.
Can we include this current defensive check in drop_buffers() and I can sub=
mit
another patch to handle that bug of AFS we discussed?

Regards,
Deepakkumar Karn


