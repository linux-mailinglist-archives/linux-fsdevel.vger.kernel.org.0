Return-Path: <linux-fsdevel+bounces-39166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797FCA10F7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A91418866D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0D422259F;
	Tue, 14 Jan 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqVQ4KzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D61FA15A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877932; cv=none; b=GprRnmgfU6G5wotkmi0/wM3w7TVSoPzuTm98thQ88VfRT7vj/sptxB8NfCj7mSSCyxh5srJwKBAeVhSLsuWrE0tNHRDu812pItvJ9sg7Zzra57Fu8BocCYjqf3B+Uk2aIwu3K8Ap8RtqDJukSLpe2JQSyE2FDxHxAZnNYIpjjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877932; c=relaxed/simple;
	bh=rHrFbFSr8oA7PcxBrUzaNoR6emoPlWh0nilg7s8rDqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtNKqW5w6Xx+/stvN3n9HFhs3uRmZu0/vBD9wmB9nZRiM6nqCv2aKigLfWo76aB1jn6nZX2VCHjVumwH+52uqIM+9cnRS6mEGmgbZ/mffzrTUjr2a9i81O9yWdppmG+znS/wtjFU4qaWv5oPD/+IFkkxh+BCjBu2qqjnIjlB2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqVQ4KzS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fR4FfFrKBIXfr5VMpSBwOitDkgT1fPynPrECh+Fo1Io=;
	b=KqVQ4KzSf/Wwmv1dhlo0C68kvZGretJz2+DHiYd7OcKnKV3TjXpGulCtUVjEmxqP7EOH4T
	4Djp44cHcTzvM3NJUdubR+hrcMmJBjTdKH/D7WhNYn4k031gbzfuPFD49FH4z6DkKyVW6Z
	kHm+tEGg3hesgmuGL99anrSl9+lSPHU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-9rMtlqdnN5aX0NMqiQrm1A-1; Tue, 14 Jan 2025 13:05:27 -0500
X-MC-Unique: 9rMtlqdnN5aX0NMqiQrm1A-1
X-Mimecast-MFC-AGG-ID: 9rMtlqdnN5aX0NMqiQrm1A
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2161d5b3eb5so105584445ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 10:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736877924; x=1737482724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fR4FfFrKBIXfr5VMpSBwOitDkgT1fPynPrECh+Fo1Io=;
        b=aCnPK5/akGS29bnojEv5psYoIDiYm5OpZSMJXk3peLPy5p/V7vHNlyCFWJAgOLQxGk
         NNHPf0YRklBgAm1jSTOoUg1uwVAAtIzhApaWkf4uACd4QBcP1ujNYwy/QwcIpIavvMer
         /2MJKCCh6geY3JjCOaNyMzTsa0wc8359ZSx7jB45b0u3KawOiGa9NxwqroWLQSK3kydC
         5hvsK7MGwjp4L2DYK2bUBvbZ6W3VpAL9yDdMtVD4QbhAHUe8skc4dFOkH3bgEflQU1fC
         nBJUuyLHkMMlh+i0uWemuqPGKkh4trzruOf8KvhMUsIjAQecp0I1y1CVuDB1jSXIRPtW
         raVQ==
X-Forwarded-Encrypted: i=1; AJvYcCULvMPog63LSil0arf4YufxvP9SEBGNqt2lJPZMHEFssVcRauQiKon/OYdrpHWC23fR93BV0mDD2kQfq8+K@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPgOX3cJEKy02A5qQdNhs3AZHYssG/FdWH/k6/0O2ViRdj09p
	0slXtU2xudsx0B9FXTxqfCKqrZJtuqeVlCvKddMVm40CuwpJxJY33Jcjeabv208eEwapgEXuwJ4
	lE+2bmHTFWLmcFusm+9ldm8koNfaSC1kSoAJe/0E6d9RRtJ+ZxA4I28mTGis9le4V9fSOWuNAGh
	rGzdYDX2FAlKsCQHe1aVSafNVDN6DumwQg6Z4H8w==
X-Gm-Gg: ASbGncuXsMHCwaXKkoFGUFGuBIOe0cmF/5OFBcXBfieFk0/hhYGD2jOi+Mb9927Hlfi
	sZc9+esc+7AVAJBNtMW0VKKw3ikonHY5+VBz6
X-Received: by 2002:a17:902:cec5:b0:215:8270:77e2 with SMTP id d9443c01a7336-21a83da4965mr382893765ad.0.1736877923826;
        Tue, 14 Jan 2025 10:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnIQ1bKYTCUptyjp6rfk1VkZqvxCakq7XwdWGZJhxuBFtjALI06UNLskeRl7HzlwtfNoUiWsJxBTuh+Y4Runk=
X-Received: by 2002:a17:902:cec5:b0:215:8270:77e2 with SMTP id
 d9443c01a7336-21a83da4965mr382893325ad.0.1736877923226; Tue, 14 Jan 2025
 10:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn> <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn> <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn> <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn> <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
In-Reply-To: <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 14 Jan 2025 19:05:11 +0100
X-Gm-Features: AbW1kvbDqb8iDbmgnGEQii-qVDbHB4He0h9IW_KUx9qA6904iyX1LDYVkpXjVAc
Message-ID: <CAHc6FU63eqRqUnrPz0JHJdenfsCTWLgagX+2zywHNTcFoZA8XQ@mail.gmail.com>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Kun Hu <huk23@m.fudan.edu.cn>, "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Cc: Andrew Price <anprice@redhat.com>, Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 5:12=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> On 13/01/2025 15:54, Kun Hu wrote:
> >
> >>
> >> 32generated_program.c memory maps the filesystem image, mounts it, and
> >> then modifies it through the memory map. It's those modifications that
> >> cause gfs2 to crash, so the test case is invalid.
> >>
> >> Is disabling CONFIG_BLK_DEV_WRITE_MOUNTED supposed to prevent that? If
> >> so, then it doesn't seem to be working.
> >>
> >> Thanks,
> >> Andreas
> >
> >
> >>   We have reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED disab=
led to obtain the same crash log. The new crash log, along with C and Syzla=
ng reproducers are provided below:
> >
> >> Crash log: https://drive.google.com/file/d/1FiCgo05oPheAt4sDQzRYTQwl0-=
CY6rvi/view?usp=3Dsharing
> >> C reproducer: https://drive.google.com/file/d/1TTR9cquaJcMYER6vtYUGh3g=
On_mROME4/view?usp=3Dsharing
> >> Syzlang reproducer: https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT=
_yn-tzm6NqmcEW-/view?usp=3Dsharing
> >
> > Hi Andreas,
> >
> > As per Jan's suggestion, we=E2=80=99ve successfully reproduced the cras=
h with CONFIG_BLK_DEV_WRITE_MOUNTED disabled. Should you require us to test=
 this issue again, we are happy to do so.
> >
> FWIW the reproducer boils down to
>
>    #include <fcntl.h>
>    #include <unistd.h>
>    #include <sys/ioctl.h>
>    #include <linux/fs.h>
>
>    /*
>       mkfs.gfs2 -b 2048 -p lock_nolock $DEV
>       mount $DEV $MNT
>       cd $MNT
>       /path/to/this_test
>     */
>    int main(void)
>    {
>            unsigned flag =3D FS_JOURNAL_DATA_FL;
>            char buf[4102] =3D {0};
>            int fd;
>
>            /* Error checking omitted for clarity */
>            fd =3D open("f", O_CREAT|O_RDWR);
>            write(fd, buf, sizeof(buf));
>            ioctl(fd, FS_IOC_SETFLAGS, &flag);
>            write(fd, buf, sizeof(buf)); /* boom */
>            close(fd);
>            return 0;
>    }
>
> So it's switching the file to journaled data mode between two writes.
>
> The size of the writes seems to be relevant and the fs needs to be
> created with a 2K block size (I'm guessing it could reproduce with other
> combinations).

I've posted a fix and pushed it to for-next:

https://lore.kernel.org/gfs2/20250114175949.1196275-1-agruenba@redhat.com/

Thanks for reporting!

Andreas


