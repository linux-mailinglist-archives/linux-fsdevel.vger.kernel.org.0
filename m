Return-Path: <linux-fsdevel+bounces-71983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92524CD978A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 14:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142963015878
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF1133A9DD;
	Tue, 23 Dec 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUqeyg6U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWoZL5Q6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBC3314B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497340; cv=none; b=lnSn7ffwJ+z58KWdUTzGtsgaW2hu2P6TRonmtDiG7ce3pPi6UMxXLVZEaon53LrRP+zoinIHvE8dTkYX1dsNyi5wlXojDez79o3UMMjn+mC/TrwkpYplbruY4zi5u/ICDiT5zCSSbuCn2Y4g/NZWwGQz5Obz055QhfPKa+WM0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497340; c=relaxed/simple;
	bh=tWMMwhXEh/7MnyAzWYu7aFM2YcxywgAseTq0WZ16L+I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FoUKHMvIVFIpo17OWaUFVWA9MIlVzdErLJnj8wPW0N/aSsFJeRb45EX/7rHZT4VrP2IbEWfNv1PmQcm86Idyff3Y/sg5YwX63EDAUeSb3/kAZtXLc6rKzhUIdv/oMz6w61JBTxakUlvERT6fMRTGgHUb2/iY8/1wNFEb+2SlPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUqeyg6U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWoZL5Q6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766497335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MPK6+AX2UJuN3wyoFSWVdC7aROs3hvfIu8qy9S8KQvE=;
	b=RUqeyg6UJYx+6DajhgIM8T421NEaXASgcu6j38mFJW24BihWORn3ZzuyH7zlApzry9x6Vs
	W75eokzfTeb1T8F5vX42R2N61iggRSfpzmVhRDFYg3gt5b165QZFS6qI3yAJnG0g3qIdaD
	9GnmOpGbi4l1QIXCFxzjcCogyUHiIYA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-L9dmuJ6AMdW1dws93Gw3Zw-1; Tue, 23 Dec 2025 08:42:14 -0500
X-MC-Unique: L9dmuJ6AMdW1dws93Gw3Zw-1
X-Mimecast-MFC-AGG-ID: L9dmuJ6AMdW1dws93Gw3Zw_1766497333
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b80055977feso607606266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 05:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766497332; x=1767102132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPK6+AX2UJuN3wyoFSWVdC7aROs3hvfIu8qy9S8KQvE=;
        b=SWoZL5Q69JbDNQYe0Jj2WCUfelVhLO4XP/wdDjjPTqOxwK06b36uLWzAI/GklkirJb
         dz6dfEtOVrzhp5CoaAEAvRNN5/YDweW3qHuTVPubzZUhCL+83opDSyj7o4Abv7Gz5RQx
         fpCM6pGTn/ndyH5bAbdDjiNq5LFlXLBZUvd7fwPjXT55T5fNn2Ok2UDt/4TkIcH/goa4
         /SpktcSysWtvFXTezrFwUdxlj9EYDwyKXCoeevWlsrKyr47SuAS7Zp8AzzgjgcuMXZnK
         hGyz05dMDCa0gMkDplg9hKoD8Ap331s+I/uoyuFDBC4S0dYpTv+A59vx5QtWkbQc6IAq
         OKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497332; x=1767102132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPK6+AX2UJuN3wyoFSWVdC7aROs3hvfIu8qy9S8KQvE=;
        b=pdhxeoVTR7LOeQFxqPV5BoZJ5d2J84ei2lc5efxZD2mZT7TbOuMLzJG7FVvW5IOnXF
         EUn/oW0XwtlGaIgl/nHNM3sVr1IBIxU3B9Bm6f/SFVWJ9ZnDIUgs3JgRv29235SxHM/V
         M+d07Ou0wXPT76nDTuurnP4Gvuf4F6KfDMesBcWbv7QaHULzaimEtIB5wLhl+MMxzZ+L
         XNdduumHvqmvEC83Lptfv6OlKVuvce/0WlMpjOsfGTrTPsuCoZJhBTr4bL0moqoLxWgW
         Cc8oG58jEL4UGkmjrSYBenPktE+diCctRbwExlcgnHkT0GO01xUjzVkbeFbAAP0Zbs6M
         t3Lw==
X-Gm-Message-State: AOJu0YxUWW5J6fc24Wy/hJTX0Nbs0UyKcDGgRmoylD4k2reTPw5UT1kV
	RQXu7hRbbkGLp1MIXldW+BR27EHSWB/nndB3btmm36CUS9bFRzdQFrIxsaBFMk7ABUQue4CdjRL
	WO/GHLweUC5/+rwcE55f+tXHj+Wyz07wYC6LB0xXDkpGfpJE2ltxA59b/HJF55gr6zUOzZ/NjNX
	fA3xnRZAwPx4JotJa/sd0FlPmhTYvGgEgSe9l6Od+1dkhCtZGFPMs=
X-Gm-Gg: AY/fxX5ZmZvlAFWZMLYJe5d3nyaLb7w8/1DZms+phVZ4GmBREPdm2RO93EnFR/uScWy
	qfesjd3BLOP0h6IYb819c4PqiDgggfy9fSMVIFMIvrg1eownIsbGPVwfg0kINzrAim6lKJV2SCP
	SIhK5QPr5/K7sxmsaXGaqAtwHmU2t8hOlqbs1dCt+4Z70y0khSf5QAgnF5SKkKftpXVg==
X-Received: by 2002:a17:907:97d6:b0:b73:7b5d:e781 with SMTP id a640c23a62f3a-b803719727cmr1617786066b.48.1766497332360;
        Tue, 23 Dec 2025 05:42:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC191fL7EdBTUCP1bqVjDrDc0aeOeHQg5A2SeIVll/ndvuUapkO2UMu1dZOY22YG/o+p9RrhVfIndWQH3dstc=
X-Received: by 2002:a17:907:97d6:b0:b73:7b5d:e781 with SMTP id
 a640c23a62f3a-b803719727cmr1617783866b.48.1766497331929; Tue, 23 Dec 2025
 05:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kun Wang <kunwan@redhat.com>
Date: Tue, 23 Dec 2025 21:42:00 +0800
X-Gm-Features: AQt7F2r3UbMxnOzn2KqHzpErYADYVUgLS9RtbiaOnyN4oZ4ggR54ccyk4Zu6qUQ
Message-ID: <CAGzaKq=1cc-N5rJS6szwzfnCsTycBjSaxPC8B4s760sniXZHOw@mail.gmail.com>
Subject: 
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Zirong Lang <zlang@redhat.com>, amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This issue was found when I was doing overlayfs test on RHEL10 using
unionmount-test-suite. Confirmed upstream kernel got the same problem
after doing the same test on the latest version with latest xfstests
and unionmount-testsuite.

[root@dell-per660-12-vm-01 xfstests]# uname -r
6.19.0-rc2+

This issue only occurs when new mount API is on, some test cases in
unionmount test-suite start to fail like below after I set a
long-name(longer than 12 characters)  test dir:

[root@dell-per660 xfstests]# ./check -overlay overlay/103
FSTYP         -- overlay
PLATFORM      -- Linux/x86_64 dell-per660-12-vm-01 6.19.0-rc2+ #1 SMP
PREEMPT_DYNAMIC Tue Dec 23 03:56:43 EST 2025
MKFS_OPTIONS  -- /123456789abc
MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /123456789abc
/123456789abc/ovl-mnt

overlay/103        - output mismatch (see
/root/xfstests/results//overlay/103.out.bad)
    --- tests/overlay/103.out   2025-12-23 05:30:37.467387962 -0500
    +++ /root/xfstests/results//overlay/103.out.bad     2025-12-23
05:44:53.414195538 -0500
    @@ -1,2 +1,17 @@
     QA output created by 103
    +mount: /123456789abc/union/m: wrong fs type, bad option, bad
superblock on overlay, missing codepage or helper program, or other
error.
    +       dmesg(1) may have more information after failed mount system ca=
ll.
    +Traceback (most recent call last):
    +  File "/root/unionmount-testsuite/./run", line 362, in <module>
    +    func(ctx)
    +  File "/root/unionmount-testsuite/tests/rename-file.py", line
96, in subtest_7
    ...
    (Run 'diff -u /root/xfstests/tests/overlay/103.out
/root/xfstests/results//overlay/103.out.bad'  to see the entire diff)
Ran: overlay/103
Failures: overlay/103
Failed 1 of 1 tests

So I looked into unionmount-testsuite, and picked out the cmdline
reproducer for this issue:

//make a long name test dir and multiple lower later dir init//
[root@dell-per660 xfstests]# mkdir -p /123456789abcdefgh/l{0..11}
[root@dell-per660 xfstests]# mkdir /123456789abcdefgh/u
/123456789abcdefgh/m /123456789abcdefgh/w
[root@dell-per660 xfstests]# ls /123456789abcdefgh/
l0  l1  l10  l11   l2  l3  l4  l5  l6  l7  l8  l9  m  u  w

//do overlay unionmount with below cmd will tigger the issue://
[root@dell-per660 xfstests]# mount -t overlay overlay
/123456789abcdefgh/m -orw,index=3Don,redirect_dir=3Don
-olowerdir=3D/123456789abcdefgh/l1:/123456789abcdefgh/l2:/123456789abcdefgh=
/l3:/123456789abcdefgh/l4:/123456789abcdefgh/l5:/123456789abcdefgh/l6:/1234=
56789abcdefgh/l7:/123456789abcdefgh/l8:/123456789abcdefgh/l9:/123456789abcd=
efgh/l10:/123456789abcdefgh/l11:/123456789abcdefgh/l0,upperdir=3D/123456789=
abcdefgh/u,workdir=3D/123456789abcdefgh/w

mount: /123456789abcdefgh/m: wrong fs type, bad option, bad superblock
on overlay, missing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.

//If I reduce the length of test dir name by 1 character, the mount
will success://
[root@dell-per660 xfstests]# cp /123456789abcdefgh /123456789abcdefg -r
[root@dell-per660 xfstests]# mount -t overlay overlay
/123456789abcdefg/m -orw,index=3Don,redirect_dir=3Don
-olowerdir=3D/123456789abcdefg/l1:/123456789abcdefg/l2:/123456789abcdefg/l3=
:/123456789abcdefg/l4:/123456789abcdefg/l5:/123456789abcdefg/l6:/123456789a=
bcdefg/l7:/123456789abcdefg/l8:/123456789abcdefg/l9:/123456789abcdefg/l10:/=
123456789abcdefg/l11:/123456789abcdefg/l0,upperdir=3D/123456789abcdefg/u,wo=
rkdir=3D/123456789abcdefg/w
[root@dell-per660 xfstests]# df -h | grep overlay
overlay          57G   29G   28G  52% /123456789abcdefg/m

 //If force using mount2 api, the mount will be good too://
[root@dell-per660 xfstests]# export LIBMOUNT_FORCE_MOUNT2=3Dalways
[root@dell-per660 xfstests]# mount -t overlay overlay
/123456789abcdefgh/m -orw,index=3Don,redirect_dir=3Don
-olowerdir=3D/123456789abcdefgh/l1:/123456789abcdefgh/l2:/123456789abcdefgh=
/l3:/123456789abcdefgh/l4:/123456789abcdefgh/l5:/123456789abcdefgh/l6:/1234=
56789abcdefgh/l7:/123456789abcdefgh/l8:/123456789abcdefgh/l9:/123456789abcd=
efgh/l10:/123456789abcdefgh/l11:/123456789abcdefgh/l0,upperdir=3D/123456789=
abcdefgh/u,workdir=3D/123456789abcdefgh/w
[root@dell-per660 xfstests]# df -h | grep overlay
overlay          57G   29G   28G  52% /123456789abcdefg/m
overlay          57G   29G   28G  52% /123456789abcdefgh/m

So I don't think this unionmount cmd had reached the limit of param
length, since it's working with the old mount API.
Then maybe a kernel bug needs to be fixed.

Thanks
Kun


