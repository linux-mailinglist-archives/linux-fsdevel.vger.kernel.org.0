Return-Path: <linux-fsdevel+bounces-72029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B98CDB8EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 08:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D28301AD05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 07:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC212E2F1F;
	Wed, 24 Dec 2025 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFSmFTUD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTetED9R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38028E571
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766559985; cv=none; b=uRGj9DuALaVdL7RmRKOdSSTROzao/xkKV++I4M+b4s+UmWQLD/kllp4cODbIP78i4LQhZ28rBchwz7I7VyPH6mgsQXdQl24RQSUi0jbJX+z7JaQux1rci3ZzeV5NGgIY8Erf/eoqCb0Xibgo7fHp7LgOXwMcySU9sgUB11Gp5UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766559985; c=relaxed/simple;
	bh=laYmGVXQTx9s8egjdTQkche7RUWnfWYif7qFihsicJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBOotem+nklUUYAjPodjujM9yb3AN8T/IA2FbmrIBZaA+6WJlGlsclYmUXkoh7WshqGzv1uFMW7xsEsN6Am2iczuZO9Qpu9q8Dg9aM4m5feeup3EtJ7SaFW2n/2I/BcnHdJFx6LSC8OdIp4yBqW5y9aSYb0RxBQMpK+pvpJFcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFSmFTUD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTetED9R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766559982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTNK8N5IMwYFWI2kcVlaUlpnbxCaDt+TdhRbB4hmuYM=;
	b=eFSmFTUDYz/IxUmzOWJX8MMnX4CueRv/hLtq1U1OYvL6wmRtJiqLIp1/ssw/eV8J+FKAWV
	m9Ng7PVAikKTwL8iIYznIcohDMyaI74aaftPh0bFJ2AVEuWMaEwbfwIgsHVfXeTM99hGQU
	3yw2yrSnU+E18vtlnIq43/cN0eVAk10=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-1XGzi8PwNTujSPeEA0SleQ-1; Wed, 24 Dec 2025 02:06:20 -0500
X-MC-Unique: 1XGzi8PwNTujSPeEA0SleQ-1
X-Mimecast-MFC-AGG-ID: 1XGzi8PwNTujSPeEA0SleQ_1766559979
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0dabc192eso126465645ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 23:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766559979; x=1767164779; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yTNK8N5IMwYFWI2kcVlaUlpnbxCaDt+TdhRbB4hmuYM=;
        b=RTetED9RXw9p4RfHjqgx29uNpHHyF4+x6a/5sPW3nFSxjqK5eFtVyyaORIE00MiLwy
         GxRQOG7SseHBq2jD+F0yRdjqUfmWJAAydmb8EmfJgaLV8BNoFjRkyroTNVXJtI2agZRh
         nWW4dEoSWuQ4VxzXFS+OZs/soukYvxu5yuBaB9axU/CXpMJ40mP4T+OCWx9PoBNEAwGe
         5qM929ggCvGLFumNiElgyLpJd51APaJxtbpl6slEEdOK8oOGoWnALg+RN7yQiKJmD7iV
         OVTriV4h+oE+ZpNdXRBmlMFVrs6MYhHQjQLjJ4B0p3XUgoSkUb4pjM6GZMnrCpVQ1xZi
         pkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766559979; x=1767164779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTNK8N5IMwYFWI2kcVlaUlpnbxCaDt+TdhRbB4hmuYM=;
        b=gFcfJz/YOBoWBAwCuaMZhLgWDfW/Trz/CAx3Be/p6um2AAshTL+FBV81QvaGgF23Dn
         c9chN8VssrlBz5lIhwiPDJ5LvYqPAsvgIfKk4k36p7DleqLLF6aTV5lupnzS3RiZIZ5Q
         0Jm3FlDhwwnPKieNTLsxEnnc/Rp1N8lB7rN2yGFNPMP0vrQL4Cyo/EAZVacNU+mt56xr
         iexlsH0XV4VXGQBfr/MUazPwGVwRp0r5eig5VTZG+OkVY1vNK79M7AwxE6FY+6Nn+sjB
         kKyYuplQJl0SoAN7DEChmcxxYnPdQt3wC4tCmxHTS+0F9aDzOiHS60gpg+/eKdKp5TRC
         jaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuxRpAcdelNQUR04ptQN0eiwLt/fYlYcUHj7lCA86eW5MVe7kPP9Lai9mZOg6NYoWETwQG/PKbe9zfWiLK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iIgzbJbePB0ZRh+PTiPqfKjmULM9fpzOZPqvSikyMhhmf0mE
	mP6SuaW5T9FYIT52pS189o5quOB77Li2AHssmvay4SbR8SEYAkA7xdnm80iLUqc/FwHNIZHuP0T
	SsfEh/uK8Lefj+BUJi716DoBW/1oxI+GkMzc9H6EVS+nSWX7OdDBig+BrRi2FnTHCqm4=
X-Gm-Gg: AY/fxX6vlJRaj7QadogB73BTmLMpLeWnxDoHBSEPK0bQtYIKoNuF9oN9tT3yx+SaCJ4
	7K5t+46jQBDKM9xFyL4b+zQ3XEHLv5Kagy/lxlpzM1wFhHa0/wp7IUq1STKVmJ6wkpczqYapKOG
	vcpq2pYi3daRN/76P4zglCNssePGOLB1O8A7aTp6D9126nyG5Wa1OsvBOmxUadL+ft4d1Hp40gd
	FLgDfyClfUK4HYURR1WZrU7EVI8QY1TiR1nGV5nePnMSj6F7QqWNwIk8LaIRwea+CFqXjugDhpM
	rAW0Fg5sUH8+DJfDoyxYvyxICs8nflTbj7a9PVAfD2FJU/yoG+ZiQwTAZvoTWHfsRUzaMeFRIXy
	gjsWGV1Eg/OUeIVnRwylNx3rJXLhGzIA2+wnznyS4V2rf/AyNWw==
X-Received: by 2002:a17:903:3d10:b0:2a1:388d:c084 with SMTP id d9443c01a7336-2a2f282fb33mr164800525ad.42.1766559979058;
        Tue, 23 Dec 2025 23:06:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmLjk/9vH8IV56+7bxKE7j8D+vInGhW+ctNgLZy/l8HfmzGDXRT6MXThyC/dJszLL0XfJ7JA==
X-Received: by 2002:a17:903:3d10:b0:2a1:388d:c084 with SMTP id d9443c01a7336-2a2f282fb33mr164800405ad.42.1766559978640;
        Tue, 23 Dec 2025 23:06:18 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c9b52asm145403985ad.45.2025.12.23.23.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 23:06:17 -0800 (PST)
Date: Wed, 24 Dec 2025 15:06:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Kun Wang <kunwan@redhat.com>, Christian Brauner <brauner@kernel.org>,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: overlay unionmount failed when a long path is set
Message-ID: <20251224070613.hfhhlnz4uq2nf47f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <CAGzaKqnw+218VAa_L-XfzcrzivV31R-OdAO1xjAT1p_Boi94dg@mail.gmail.com>
 <CAOQ4uxi505WQB1E1dSYXcVGf9b5=HT-Cz55FMNw5RxnE=ww2yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi505WQB1E1dSYXcVGf9b5=HT-Cz55FMNw5RxnE=ww2yA@mail.gmail.com>

On Tue, Dec 23, 2025 at 03:48:50PM +0100, Amir Goldstein wrote:
> On Tue, Dec 23, 2025 at 3:25 PM Kun Wang <kunwan@redhat.com> wrote:
> >
> > Hi,
> >
> > This issue was found when I was doing overlayfs test on RHEL10 using unionmount-test-suite. Confirmed upstream kernel got the same problem after doing the same test on the latest version with latest xfstests and unionmount-testsuite.
> > [root@dell-per660-12-vm-01 xfstests]# uname -r
> > 6.19.0-rc2+
> >
> > This issue only occurs when new mount API is on, some test cases in unionmount test-suite start to fail like below after I set a long-name(longer than 12 characters)  test dir:
> >
> > [root@dell-per660 xfstests]# ./check -overlay overlay/103
> > FSTYP         -- overlay
> > PLATFORM      -- Linux/x86_64 dell-per660-12-vm-01 6.19.0-rc2+ #1 SMP PREEMPT_DYNAMIC Tue Dec 23 03:56:43 EST 2025
> > MKFS_OPTIONS  -- /123456789abc
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /123456789abc /123456789abc/ovl-mnt
> >
> > overlay/103        - output mismatch (see /root/xfstests/results//overlay/103.out.bad)
> >     --- tests/overlay/103.out   2025-12-23 05:30:37.467387962 -0500
> >     +++ /root/xfstests/results//overlay/103.out.bad     2025-12-23 05:44:53.414195538 -0500
> >     @@ -1,2 +1,17 @@
> >      QA output created by 103
> >     +mount: /123456789abc/union/m: wrong fs type, bad option, bad superblock on overlay, missing codepage or helper program, or other error.
> >     +       dmesg(1) may have more information after failed mount system call.
> >     +Traceback (most recent call last):
> >     +  File "/root/unionmount-testsuite/./run", line 362, in <module>
> >     +    func(ctx)
> >     +  File "/root/unionmount-testsuite/tests/rename-file.py", line 96, in subtest_7
> >     ...
> >     (Run 'diff -u /root/xfstests/tests/overlay/103.out /root/xfstests/results//overlay/103.out.bad'  to see the entire diff)
> > Ran: overlay/103
> > Failures: overlay/103
> > Failed 1 of 1 tests
> >
> > So I looked into unionmount-testsuite, and picked out the cmdline reproducer for this issue:
> >
> > //make a long name test dir and multiple lower later dir init//
> > [root@dell-per660 xfstests]# mkdir -p /123456789abcdefgh/l{0..11}
> > [root@dell-per660 xfstests]# mkdir /123456789abcdefgh/u /123456789abcdefgh/m /123456789abcdefgh/w
> > [root@dell-per660 xfstests]# ls /123456789abcdefgh/
> > l0  l1  l10  l11   l2  l3  l4  l5  l6  l7  l8  l9  m  u  w
> >
> > //do overlay unionmount with below cmd will tigger the issue://
> > [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcdefgh/m -orw,index=on,redirect_dir=on -olowerdir=/123456789abcdefgh/l1:/123456789abcdefgh/l2:/123456789abcdefgh/l3:/123456789abcdefgh/l4:/123456789abcdefgh/l5:/123456789abcdefgh/l6:/123456789abcdefgh/l7:/123456789abcdefgh/l8:/123456789abcdefgh/l9:/123456789abcdefgh/l10:/123456789abcdefgh/l11:/123456789abcdefgh/l0,upperdir=/123456789abcdefgh/u,workdir=/123456789abcdefgh/w
> >
> > mount: /123456789abcdefgh/m: wrong fs type, bad option, bad superblock on overlay, missing codepage or helper program, or other error.
> >        dmesg(1) may have more information after failed mount system call.
> >
> > //If I reduce the length of test dir name by 1 character, the mount will success://
> > [root@dell-per660 xfstests]# cp /123456789abcdefgh /123456789abcdefg -r
> > [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcdefg/m -orw,index=on,redirect_dir=on -olowerdir=/123456789abcdefg/l1:/123456789abcdefg/l2:/123456789abcdefg/l3:/123456789abcdefg/l4:/123456789abcdefg/l5:/123456789abcdefg/l6:/123456789abcdefg/l7:/123456789abcdefg/l8:/123456789abcdefg/l9:/123456789abcdefg/l10:/123456789abcdefg/l11:/123456789abcdefg/l0,upperdir=/123456789abcdefg/u,workdir=/123456789abcdefg/w
> > [root@dell-per660 xfstests]# df -h | grep overlay
> > overlay          57G   29G   28G  52% /123456789abcdefg/m
> >
> >  //If force using mount2 api, the mount will be good too://
> > [root@dell-per660 xfstests]# export LIBMOUNT_FORCE_MOUNT2=always
> > [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcdefgh/m -orw,index=on,redirect_dir=on -olowerdir=/123456789abcdefgh/l1:/123456789abcdefgh/l2:/123456789abcdefgh/l3:/123456789abcdefgh/l4:/123456789abcdefgh/l5:/123456789abcdefgh/l6:/123456789abcdefgh/l7:/123456789abcdefgh/l8:/123456789abcdefgh/l9:/123456789abcdefgh/l10:/123456789abcdefgh/l11:/123456789abcdefgh/l0,upperdir=/123456789abcdefgh/u,workdir=/123456789abcdefgh/w
> > [root@dell-per660 xfstests]# df -h | grep overlay
> > overlay          57G   29G   28G  52% /123456789abcdefg/m
> > overlay          57G   29G   28G  52% /123456789abcdefgh/m
> >
> > So I don't think this unionmount cmd had reached the limit of param length, since it's working with the old mount API.
> > Then maybe a kernel bug needs to be fixed..
> 
> Hi Kun,
> 
> Thanks for reporting this issue.
> 
> We've had several issues with systems that are upgraded to linmount
> that uses new mount API by default.
> 
> FYI, the lowerdir+ mount option was added exactly to avoid these sorts
> of limits, but that will require changing applications (like unionmount
> testsuite) to use this more scalable mount options or require libmount
> to automatically parse and convert a long lowerdir= mount option to
> smaller lowerdir+= mount options.

Hi Amir,

Thanks for your quick reply :) Maybe you remember we talked in an email
"fstests overlay/103~109, 114~119 always fail". You said these tests always
passed for you after your commit:

  commit e6fc42f16c77ea40090b7168a7195ea12967b012
  Author: Amir Goldstein <amir73il@gmail.com>
  Date:   Tue Jun 3 12:07:40 2025 +0200

    overlay: workaround libmount failure to remount,ro

But they're still failed on my side. Our discussion was interrupted due to I got
other busy things. Recently I asked Kun to go to track this issue again, so this
is a follow-up of that. We've excluded some conditions, now the only one difference
between your test(passed) and mine (failed) might be the name (or name length) of
SCRATCH_MNT.

Thanks,
Zorro

> 
> Christian,
> 
> Do you remember seeing this phenomenon when working on the new mount API?
> I might have known about it and forgot...
> 
> Thanks,
> Amir.
> 


