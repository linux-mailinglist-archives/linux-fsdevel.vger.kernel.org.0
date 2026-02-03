Return-Path: <linux-fsdevel+bounces-76230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAFiKnt9gmnAVQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 23:58:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2447FDF780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 23:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F806304A30D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 22:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE34374723;
	Tue,  3 Feb 2026 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+odSLgf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvqrxqc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51F371048
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159470; cv=pass; b=cwLGy48RQV/Bf7EoThfTYki7x2U3RajYZ5hVKKeUqCDw9BRQiicLJzW+iCiiZmWU7At/37nPzGgkmvUjgMazz1TdN7ZtH8mSHY5yy6IsX91mj/fgUoXZd8kCQoOvMGRiTs9jVAuOLVEKR4hbFwV7uBtQ7GUg9rw4P1kV5bMrJX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159470; c=relaxed/simple;
	bh=90gHrRJjFzBRKuDUGQi6rDSEIq2oFFXAyceJbpON+/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKNMEG2mZN7cI5Ije3OC0zHhU7VOLYSEf0PVs2uSocHDB2B66dKe0RfoU7zdppG6+vYdFT9vsF2syMTr9nQg+A7mS361SOg7iWDn6iphRKp76w46qjgDOTaOBS6cyYkiEj0xxxWHxl+83QpEPij1fB0i9geW7lJq+qAtLm0kdwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+odSLgf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvqrxqc6; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770159466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLIewwKrZqCrsNtp5DDGZF4Aucf3VKHSe7nnaoeGzC0=;
	b=g+odSLgfPYSmLw5n0Nn5xlAl8w80FwHp5U3KnqdEzh4EWucuaLWHP4cmPLqb9yom/NxQva
	MIemL2iJdgw1zXzw1Q1DpEsYRMO6UIpKNxT5td2zLEjYkqk+fTCXVFG29c+ni2DziEWYTJ
	de9ooMhMNzsqC7XMSmbtg38CGbjDJcs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-6VFfN0LqNGCPu6-AMD8rTg-1; Tue, 03 Feb 2026 17:57:45 -0500
X-MC-Unique: 6VFfN0LqNGCPu6-AMD8rTg-1
X-Mimecast-MFC-AGG-ID: 6VFfN0LqNGCPu6-AMD8rTg_1770159464
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-382fcf9cb7dso33481921fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 14:57:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770159463; cv=none;
        d=google.com; s=arc-20240605;
        b=eQuTBt4+pVxp2WYf1PlMt2JzHGWV3BlTlMM4Z7hdGOM3guNknAko4E+1KQYGrf3Av9
         S0US1q68/G2X9sgXaUFaKByrHbijC5wZypckVBDfkPMtjQFzJpV3PfnOBBHSSewaG8d1
         L0rp6yLZQUq6KvVnbdVqkEL6IwpSTltJd3/osmjZnuupw9aK7GQALSC4/Z6iO/cehf01
         Gv4uVTp0PPd59qNIpD28mSEKUVXoLW7V5Nmd3UV26aGNKwc+bVyXpVFArIMg9m8pTeg4
         Enm3XQWP5vlpso4pIr9jfvNXgdVQg96JuUAPxWX1f1OUn4APCLtEsV7hhbDlVdBc1SjN
         VmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yLIewwKrZqCrsNtp5DDGZF4Aucf3VKHSe7nnaoeGzC0=;
        fh=l76gBv9uZ+cyxcawZR+dr9c8Afcrb8SBEgvLXZoyPu4=;
        b=XZqsJkPSgRUvLv0q9JOj4ll2ULcFNZ5gsXYiA0ODvU3X7kyKhZipDvyOACeO1bk/UH
         A2tn9Io5uzbUviANbZOsOPzp1gQH2Zq79aF5MgxCVTQ3BP3b62z7xFtK32kVD5E0RRBa
         bGoBObTz2OYZbTgujmZEAepeMaDBeDgUiiKY+JS+IsgueVtXfa70S9Dy0pliCTcmIXdC
         gONnt6MjKn6RGhFDcsLdsFDo+/sn1i1bx0szH0j7DC0AJ95hhqIIX7Ni347oiiXHaNP2
         x6A+V7LuwTDhwknlDG3L2+S35hySXPK5BkZbjZ7E4w+92zyks8kXyJGlYBkdtEXtCp/w
         Z4Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770159463; x=1770764263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLIewwKrZqCrsNtp5DDGZF4Aucf3VKHSe7nnaoeGzC0=;
        b=dvqrxqc6wfDUNChy6XFhpAZcPoMqM3iHMyJVBYBD7HF4vHgjgHCWD61keAy7srzzLu
         M2D6VWf3l0zP1civfejhnagpPAyH/VvPhO+96M29oj0LDYm7xztf9XExeEzFo6QplyrX
         9g3qLpcE/oq9ZAnFTTKmL71lwRGqKHx1stfr/eXI+z9Az+ymMcF6N7Q/rnQe/Ex4Y9Wy
         +InHmZ3Xr5iSqgDOYd/O/D8jISnBcsc/k1DOwgh8mUM+YF9iKM/tsWmbEOuuZMBV510t
         JtWbOTyJrW1zER/ye37qh00RvHXQyDqfXKYMD4OMHhBGOj6cGwgQA5i8nTPQuemXu52H
         miuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159463; x=1770764263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLIewwKrZqCrsNtp5DDGZF4Aucf3VKHSe7nnaoeGzC0=;
        b=lzVvyKUw2lW1iP7dU+8CW4UPp/NEl29nVmu7jsG9p0Ir2FNzwlKsx0VAMLUx5twYfF
         Y5a+QoXCSqLok03V9YX5jZSmrU+tlcGuJTmNrAdnQWk/Xqju/ZtuPQ6FGIzqKGmorwqe
         cqdbUF8cGKiDM+hS44U89s4zEfn2KNyvuhIUOSThn35eBCASGvwPtc60lHHua+iqw5ka
         jG8fyEyKa1rwn2H4tneRmccfVfHgmJDlAsBjBQRG6UTnXnKd1GmyuoWqswqUk8TjnNcg
         Ux8Pa/tJ9778xlDgzynv+uupQXTedbsU/FmAGarmTVmdTtRnbN2qei858aBB24+wyABu
         hHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGZlbaJbPP4aBT25PJLVEUCAVndExXJfoBCeuXNmRZAlUbxY8wQNPN0D6wZ1UwS0Qwr55xbRRXurkklw2h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9U2ntU1pUlhaOQ51xPr9hCMOLS9ikFiYxemhOoKEvqhColG0
	chxSrUwNblCZ835KWbFtqeCqmCw+OiTFitCQLccREBAYL2K6Y8pRTkHZ7F1WyJgNZUOxvtOQuc9
	M3CZ3vzxMm7lvq0sZKuMlPFfcnt120TG+n6hrdjPT+en04qrK0KfsOWG47R+NygQLR4zuNRq4Ld
	tr951hP1+e3z4WRnaVbTmkvFRARx9s6rVsCBr5KF/wzw==
X-Gm-Gg: AZuq6aIhDQO+wsyrbD37tLk5lh4o0NHDUJFtugctGByct2KvdLV5hPH3e64UwOy89bf
	MgBoJLoQ7B5WmnYF28RwoBAezB4c6Jt1hQWAkmtvgWI8OAj2yBoeS+stghDyUttjoKC86SZ6Z4L
	7bw7dVnibYG1BevjSkpaTNnVr+yhq4JTawZyrr9xM2rK2XaUv1SMiQU5Q05+iggY1JM7tu49GoV
	2g+apcLYsYJABhK5uRbTzMQ0A==
X-Received: by 2002:a05:6512:2512:b0:59e:708:d15d with SMTP id 2adb3069b0e04-59e38c581f6mr319322e87.47.1770159463392;
        Tue, 03 Feb 2026 14:57:43 -0800 (PST)
X-Received: by 2002:a05:6512:2512:b0:59e:708:d15d with SMTP id
 2adb3069b0e04-59e38c581f6mr319310e87.47.1770159462915; Tue, 03 Feb 2026
 14:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203225445.1515933-2-slava@dubeyko.com>
In-Reply-To: <20260203225445.1515933-2-slava@dubeyko.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Tue, 3 Feb 2026 17:57:16 -0500
X-Gm-Features: AZwV_QgzetLaHgdBcRKeStMpe0ybq-8jwJa8dhIDEjrLEiArgakfdAFhcKlx7Ew
Message-ID: <CA+2bHPaKEAfDfMkjCqpFC1PPgn4MxYrfXKRWxnOd0VV59D_oOA@mail.gmail.com>
Subject: Re: [PATCH v6] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-76230-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pdonnell@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ceph.com:url,dubeyko.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2447FDF780
X-Rspamd-Action: no action

Reviewed-by: Patrick Donnelly <pdonnell@ibm.com>
Tested-by: Patrick Donnelly <pdonnell@ibm.com>

On Tue, Feb 3, 2026 at 5:55=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The CephFS kernel client has regression starting from 6.18-rc1.
>
> sudo ./check -g quick
> FSTYP         -- ceph
> PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYNAM=
IC Fri
> Nov 14 11:26:14 PST 2025
> MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/scr=
atch
> /mnt/cephfs/scratch
>
> Killed
>
> Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> (2)192.168.1.213:3300 session established
> Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL pointer
> dereference, address: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read acc=
ess in
> kernel mode
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000) =
- not-
> present page
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] SM=
P KASAN
> NOPTI
> Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 3453 =
Comm:
> xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU Stan=
dard PC
> (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff8881536875=
c0
> EFLAGS: 00010246
> Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 RB=
X:
> ffff888116003200 RCX: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff88810126c900
> Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(00=
00)
> GS:ffff8882401a4000(0000) knlGS:0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 CR=
3:
> 0000000110ebd001 CR4: 0000000000772ef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> ceph_mds_check_access+0x348/0x1760
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> __kasan_check_write+0x14/0x30
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x17=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> __pfx_apparmor_file_open+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> __ceph_caps_issued_mask_metric+0xd6/0x180
> Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/0x=
10e0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x50=
a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0x1=
0/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> __pfx_stack_trace_save+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> stack_depot_save_flags+0x28/0x8f0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0xe/=
0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x45=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> __pfx__raw_spin_lock_irqsave+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+0x=
10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d/0=
x2b0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> __check_object_size+0x453/0x600
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0xe/=
0x40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0x1=
80
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> __pfx_do_sys_openat2+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x108/=
0x240
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> __pfx___x64_sys_openat+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> __pfx___handle_mm_fault+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0x2=
350
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0xd5=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/0x=
d50
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+0x=
11/0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> count_memcg_events+0x25b/0x400
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x38b=
/0x6a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+0x=
11/0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> irqentry_exit_to_user_mode+0x2e/0x2a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/0x=
50
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95/0=
x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145ab
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3d =
00 00
> 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c f=
f ff ff
> b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28=
 64 48
> 2b 14 25
> Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d316=
d0
> EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda RB=
X:
> 0000000000000002 RCX: 000074a85bf145ab
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 RS=
I:
> 00007ffc77d32789 RDI: 00000000ffffff9c
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 R0=
8:
> 00007ffc77d31980 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 R1=
1:
> 0000000000000246 R12: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff R1=
4:
> 0000000000000180 R15: 0000000000000001
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_=
core
> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vse=
c
> kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_=
intel
> rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgasta=
te
> serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc ppd=
ev lp
> parport efi_pstore
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 000000000=
0000000
> ]---
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff8881536875=
c0
> EFLAGS: 00010246
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 RB=
X:
> ffff888116003200 RCX: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff88810126c900
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(00=
00)
> GS:ffff8882401a4000(0000) knlGS:0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 CR=
3:
> 0000000110ebd001 CR4: 0000000000772ef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
>
> We have issue here [1] if fs_name =3D=3D NULL:
>
> const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
>     ...
>     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
>             / fsname mismatch, try next one */
>             return 0;
>     }
>
> v2
> Patrick Donnelly suggested that: In summary, we should definitely start
> decoding `fs_name` from the MDSMap and do strict authorizations checks
> against it. Note that the `--mds_namespace` should only be used for
> selecting the file system to mount and nothing else. It's possible
> no mds_namespace is specified but the kernel will mount the only
> file system that exists which may have name "foo".
>
> v3
> The namespace_equals() logic has been generalized into
> __namespace_equals() with the goal of using it in
> ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
>
> v4
> The __namespace_equals() now supports wildcard check.
>
> v5
> Patrick Donnelly suggested to add the sanity check of
> kstrdup() returned pointer in ceph_mdsmap_decode()
> added logic. Also, he suggested much simpler logic of
> namespace strings comparison in the form of
> ceph_namespace_match() logic.
>
> v6
> Only ceph_namespace_match() compares the names
> with CEPH_NAMESPACE_WILDCARD.
>
> This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> the goal of supporting the suggested concept. Now struct ceph_mdsmap
> contains m_fs_name field that receives copy of extracted FS name
> by ceph_extract_encoded_string(). For the case of "old" CephFS file syste=
ms,
> it is used "cephfs" name. Also, namespace_equals() method has been
> reworked with the goal of proper names comparison.
>
> [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_client.=
c#L5666
> [2] https://tracker.ceph.com/issues/73886
>
> Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/mds_client.c         | 11 +++++------
>  fs/ceph/mdsmap.c             | 24 ++++++++++++++++++------
>  fs/ceph/mdsmap.h             |  1 +
>  fs/ceph/super.h              | 29 ++++++++++++++++++++++++-----
>  include/linux/ceph/ceph_fs.h |  6 ++++++
>  5 files changed, 54 insertions(+), 17 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 7e4eab824dae..a4b9254b74a5 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_clie=
nt *mdsc,
>         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
>         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
>         struct ceph_client *cl =3D mdsc->fsc->client;
> -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
>         const char *spath =3D mdsc->fsc->mount_options->server_path;
>         bool gid_matched =3D false;
>         u32 gid, tlen, len;
> @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_clie=
nt *mdsc,
>
>         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
>               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) =
{
> +
> +       if (!ceph_namespace_match(auth->match.fs_name, fs_name)) {
>                 /* fsname mismatch, try next one */
>                 return 0;
>         }
> @@ -6122,7 +6123,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client =
*mdsc, struct ceph_msg *msg)
>  {
>         struct ceph_fs_client *fsc =3D mdsc->fsc;
>         struct ceph_client *cl =3D fsc->client;
> -       const char *mds_namespace =3D fsc->mount_options->mds_namespace;
>         void *p =3D msg->front.iov_base;
>         void *end =3D p + msg->front.iov_len;
>         u32 epoch;
> @@ -6157,9 +6157,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client =
*mdsc, struct ceph_msg *msg)
>                 namelen =3D ceph_decode_32(&info_p);
>                 ceph_decode_need(&info_p, info_end, namelen, bad);
>
> -               if (mds_namespace &&
> -                   strlen(mds_namespace) =3D=3D namelen &&
> -                   !strncmp(mds_namespace, (char *)info_p, namelen)) {
> +               if (namespace_equals(fsc->mount_options,
> +                                    (char *)info_p, namelen)) {
>                         mount_fscid =3D fscid;
>                         break;
>                 }
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 2c7b151a7c95..f0c0ed202184 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -353,22 +353,33 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_=
mds_client *mdsc, void **p,
>                 __decode_and_drop_type(p, end, u8, bad_ext);
>         }
>         if (mdsmap_ev >=3D 8) {
> -               u32 fsname_len;
> +               size_t fsname_len;
> +
>                 /* enabled */
>                 ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> +
>                 /* fs_name */
> -               ceph_decode_32_safe(p, end, fsname_len, bad_ext);
> +               m->m_fs_name =3D ceph_extract_encoded_string(p, end,
> +                                                          &fsname_len,
> +                                                          GFP_NOFS);
> +               if (IS_ERR(m->m_fs_name)) {
> +                       m->m_fs_name =3D NULL;
> +                       goto nomem;
> +               }
>
>                 /* validate fsname against mds_namespace */
> -               if (!namespace_equals(mdsc->fsc->mount_options, *p,
> +               if (!namespace_equals(mdsc->fsc->mount_options, m->m_fs_n=
ame,
>                                       fsname_len)) {
>                         pr_warn_client(cl, "fsname %*pE doesn't match mds=
_namespace %s\n",
> -                                      (int)fsname_len, (char *)*p,
> +                                      (int)fsname_len, m->m_fs_name,
>                                        mdsc->fsc->mount_options->mds_name=
space);
>                         goto bad;
>                 }
> -               /* skip fsname after validation */
> -               ceph_decode_skip_n(p, end, fsname_len, bad);
> +       } else {
> +               m->m_enabled =3D false;
> +               m->m_fs_name =3D kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
> +               if (!m->m_fs_name)
> +                       goto nomem;
>         }
>         /* damaged */
>         if (mdsmap_ev >=3D 9) {
> @@ -430,6 +441,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
>                 kfree(m->m_info);
>         }
>         kfree(m->m_data_pg_pools);
> +       kfree(m->m_fs_name);
>         kfree(m);
>  }
>
> diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
> index 1f2171dd01bf..d48d07c3516d 100644
> --- a/fs/ceph/mdsmap.h
> +++ b/fs/ceph/mdsmap.h
> @@ -45,6 +45,7 @@ struct ceph_mdsmap {
>         bool m_enabled;
>         bool m_damaged;
>         int m_num_laggy;
> +       char *m_fs_name;
>  };
>
>  static inline struct ceph_entity_addr *
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index a1f781c46b41..d2a586794226 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -104,18 +104,37 @@ struct ceph_mount_options {
>         struct fscrypt_dummy_policy dummy_enc_policy;
>  };
>
> +#define CEPH_NAMESPACE_WILDCARD                "*"
> +
> +static inline bool ceph_namespace_match(const char *pattern,
> +                                       const char *target)
> +{
> +       if (!pattern || !pattern[0] ||
> +           !strcmp(pattern, CEPH_NAMESPACE_WILDCARD))
> +               return true;
> +
> +       if (strlen(pattern) !=3D strlen(target))
> +               return false;
> +
> +       return !strncmp(pattern, target, strlen(pattern));
> +}
> +
>  /*
>   * Check if the mds namespace in ceph_mount_options matches
>   * the passed in namespace string. First time match (when
>   * ->mds_namespace is NULL) is treated specially, since
>   * ->mds_namespace needs to be initialized by the caller.
>   */
> -static inline int namespace_equals(struct ceph_mount_options *fsopt,
> -                                  const char *namespace, size_t len)
> +static inline bool namespace_equals(struct ceph_mount_options *fsopt,
> +                                   const char *namespace, size_t len)
>  {
> -       return !(fsopt->mds_namespace &&
> -                (strlen(fsopt->mds_namespace) !=3D len ||
> -                 strncmp(fsopt->mds_namespace, namespace, len)));
> +       if (!fsopt->mds_namespace || !fsopt->mds_namespace[0])
> +               return true;
> +
> +       if (strlen(fsopt->mds_namespace) !=3D len)
> +               return false;
> +
> +       return !strncmp(fsopt->mds_namespace, namespace, len);
>  }
>
>  /* mount state */
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index c7f2c63b3bc3..08e5dbe15ca4 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -31,6 +31,12 @@
>  #define CEPH_INO_CEPH   2            /* hidden .ceph dir */
>  #define CEPH_INO_GLOBAL_SNAPREALM  3 /* global dummy snaprealm */
>
> +/*
> + * name for "old" CephFS file systems,
> + * see ceph.git e2b151d009640114b2565c901d6f41f6cd5ec652
> + */
> +#define CEPH_OLD_FS_NAME       "cephfs"
> +
>  /* arbitrary limit on max # of monitors (cluster of 3 is typical) */
>  #define CEPH_MAX_MON   31
>
> --
> 2.52.0
>


--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


