Return-Path: <linux-fsdevel+bounces-33088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CC9B3A68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 20:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62EE6B21A0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1BA18FC84;
	Mon, 28 Oct 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FD/iYQsa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA4155A52
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143698; cv=none; b=gh2swXJejSPvQLsMsOYL68QAJ/KoNkd+qXnjcDIvo6/2bidyzPoMpyGEq0aN6a4ctqpY6HVDxghUjAFG7AX+0dTCbGBp3ebXoV4ptT4qOScwkkYt46tPl7q6qJVRzebALnv/XJKEoQnkjC89LRDKMuZ9ZS80juriYJlcrvBUMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143698; c=relaxed/simple;
	bh=j+14TS//kHOonJXDSlHsg5yxoX/1kbRoS9Vqx8BZthM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMrLUrhLEVC3oz7W+Cqlc+vIXlFx821f1L3h9a9bfjdqyMnfqzxLmoeFVp8PthY/wo9NdJfYl0bdME8D1oRBjBdmK5Yu4oe/RBUuOjw9l9MlKABl6c7cGEH0/QTVTjmyRBVVGCaa7GTHop5FP2EvgMtcaFqtoKENiiiR1EXjdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FD/iYQsa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730143695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/vg+XHXZVanDLke+k+EmxatqkcqEswwCpL2oCHyW30=;
	b=FD/iYQsajOpM7lpSxC69T+GYJMp2LrPo2cyIexuzSLmaJzEJv58f9c0meF6bPqqB+o2mU2
	CwhcyzSf1IDYc62alSJRWRVFiCVv4/m+B5gFpzea8qIhUOgVJC8A/jr2i2lpqrBGqSXM6n
	bZAaiN1fvVwLZXDWLAUrllnjeb3GNMc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-QL30GuTcORCKCabRHVcjsg-1; Mon, 28 Oct 2024 15:28:10 -0400
X-MC-Unique: QL30GuTcORCKCabRHVcjsg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20c2cffd698so49647075ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 12:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730143689; x=1730748489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/vg+XHXZVanDLke+k+EmxatqkcqEswwCpL2oCHyW30=;
        b=CpqvNG6WJLNZOnktZVJwJM1eaRKjGRuZqpjE1L8ZVTLoFKAgQqp4xurwE3dn1aY5Zx
         T8aN0ZrYLjZGq0O417nYhUCFqojtDNZTpJl5A8yKnh5Alr1/vMy/LziAnl7VRi/rougX
         CFS5pVlKODhxqjoGPNzS/PtG7zdDrTseBr9Jl12AMgRKLYaitTRCLAnkxCOM0PZoiqax
         /Vd0lDjSI0W2kMbsvS1bV27S5NUFsrwcUqiIbinnw966+r4ekfqgXtX+32HybCQ7ta+u
         FcnTfa5kW8czpqnt43gH+gt3/UESNiaVhtgYtJiK9f4CSyVFZH5/DaBarxAus3l4Nvpo
         q0hw==
X-Forwarded-Encrypted: i=1; AJvYcCUAvH3mvmgF0Mv/MBTC7Uae+189yiTLbMDXJvWNXFhb/KVbgExcL2xPO3NP/r3F49gQEKpwpCWnCIIaLHMn@vger.kernel.org
X-Gm-Message-State: AOJu0YxyikdMbruSMVAL5PVc/plcmIDb4pq7X3AUapVrIFsNwhJDHpEh
	ZY9XONRMUTliJa5s/s7/Vm+rqiN1YhA2mYyOUsUxM5znVI7aBG0TSi4q8rlk2vTYRUCWtjXcQfZ
	4Y9IcMYlXwwof427PDs5INt3kCfKOx5JpwnFYZrFhRrFWTjszABysO5fhivJ/+1XiqzfGLbDmQQ
	==
X-Received: by 2002:a17:902:ec88:b0:20c:763e:d9cc with SMTP id d9443c01a7336-210c68a1a50mr158790115ad.7.1730143688973;
        Mon, 28 Oct 2024 12:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIyJYVfKmDvL0QgeiTuWSb9GK40uweku4lW5KWUkFjAIN30XxEgH4gQ/SGJU6rDFoTPP3d+Q==
X-Received: by 2002:a17:902:ec88:b0:20c:763e:d9cc with SMTP id d9443c01a7336-210c68a1a50mr158789875ad.7.1730143688627;
        Mon, 28 Oct 2024 12:28:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc082597sm54116565ad.287.2024.10.28.12.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:28:08 -0700 (PDT)
Date: Tue, 29 Oct 2024 03:28:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, sandeen@redhat.com
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2
 (new mount APIs)
Message-ID: <20241028192804.axbj2onyoscgzvwi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-eigelb-quintessenz-2adca4670ee8@brauner>

On Mon, Oct 28, 2024 at 01:22:52PM +0100, Christian Brauner wrote:
> On Sun, Oct 27, 2024 at 02:07:41AM +0800, Zorro Lang wrote:
> > Hi,
> > 
> > Recently, I hit lots of fstests cases fail on overlayfs (xfs underlying, no
> > specific mount options), e.g.
> > 
> > FSTYP         -- overlay
> > PLATFORM      -- Linux/s390x s390x-xxxx 6.12.0-rc4+ #1 SMP Fri Oct 25 14:29:18 EDT 2024
> > MKFS_OPTIONS  -- -m crc=1,finobt=1,rmapbt=0,reflink=1,inobtcount=1,bigtime=1 /mnt/fstests/SCRATCH_DIR
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt/fstests/SCRATCH_DIR /mnt/fstests/SCRATCH_DIR/ovl-mnt
> > 
> > generic/294       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/294.out.bad)
> >     --- tests/generic/294.out	2024-10-25 14:38:32.098692473 -0400
> >     +++ /var/lib/xfstests/results//generic/294.out.bad	2024-10-25 15:02:34.698605062 -0400
> >     @@ -1,5 +1,5 @@
> >      QA output created by 294
> >     -mknod: SCRATCH_MNT/294.test/testnode: File exists
> >     -mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
> >     -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
> >     -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
> >     +mount: /mnt/fstests/SCRATCH_DIR/ovl-mnt: fsconfig system call failed: overlay: No changes allowed in reconfigure.
> >     +       dmesg(1) may have more information after failed mount system call.
> 
> In the new mount api overlayfs has been changed to reject invalid mount
> option on remount whereas in the old mount api we just igorned them.

Not only g/294 fails on new mount utils, not sure if all of them are from same issue.
If you need, I can paste all test failures (only from my side) at here.

> If this a big problem then we need to change overlayfs to continue
> ignoring garbage mount options passed to it during remount.

Do you mean this behavior change is only for overlayfs, doesn't affect other fs?

If it's not necessary, I think we'd better to not change the behaviors which we've
used so many years. But if you all agree with this change, then we need to update
related regression test cases and more scripts maybe.

Thanks,
Zorro

> 


