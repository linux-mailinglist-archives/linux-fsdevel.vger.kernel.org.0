Return-Path: <linux-fsdevel+bounces-75528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP3sLSvMd2mxlQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:18:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 207FD8CF8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BB33015478
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2F2D5419;
	Mon, 26 Jan 2026 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOY63vty";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2raP3hr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B92D47F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458717; cv=none; b=qxA4bgeQ2B+wYY0mVVwhw6q7sTZyLDKYy89JjSh563ZXoMewWK8lV1uskva4hDc/G9jUgp8w/wk8i09veQ4eWP+jRbzqS5oSD3kHQVtyao786ZqF8xqrsCXm9ZcohLxvtG08U1ufZCMvxvpFwOUDy2PD6064UuaJlrlGOowj8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458717; c=relaxed/simple;
	bh=DwlfjU7xG+O/YXuRHp0dMx2H9m8UllLp/Zt+WLpRATo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qh/4REaNL6Hm78YDr+TMzH8JuWrwGNre0QDlbDZIcmCZUNFA2S+WFhhKc1+8MsmVissmqNDIeyFgEfhrAt5pB7GGNspndvpKPUuULAzj+FER0FW9ZGgZrLk8ad+EBizIcUCnJANOM0sryv8z4nsmOqRNIaYV6j4zo8okFbcZLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOY63vty; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2raP3hr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769458714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NE7PtpLtQZOd0aAX87tJllaXQzvrrs347Pi8ubbeDQs=;
	b=ZOY63vtySFw5LNOaHqmUJcTU4pFpS1RMAtzu7o8mbNAsVsyx2xECtRO5rtsrRF9u61nS9I
	CZJ2vwKO2gxLsyjAcFF+mlsfYmF8kueCv7/ZsAMqb5iU3Nj8YB4Ez4farzDkhXbKZo25XK
	f50dd6sE9r8Pozuvp++E9m+5dL5n2C4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-ExKcMq-ePca6swfSKIAbFw-1; Mon, 26 Jan 2026 15:18:33 -0500
X-MC-Unique: ExKcMq-ePca6swfSKIAbFw-1
X-Mimecast-MFC-AGG-ID: ExKcMq-ePca6swfSKIAbFw_1769458712
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78f92e123f5so62996297b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 12:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769458712; x=1770063512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NE7PtpLtQZOd0aAX87tJllaXQzvrrs347Pi8ubbeDQs=;
        b=S2raP3hr+d4Gza1gZpXZsPNhIEH/2gO5h8I2klQ/D4sN2kUI1cB+wBnRobzYa4DA0P
         mcSjSeRvwGBKwQyxw7JIUW8fJl7dEPtMj49bOwroXxSLFTgyo0AmyBkcdGgH56H3gdhh
         /rWIOE99T++v6Zy7DtzyqpJyg/F5qEr15n15NukOb6WtUZsEW29WIEtWaKnTqL2WMv5A
         ZUqFCGg4Z9vYfUl7++/gxnG6emnPD2gpIR9fePSMWc2/MtBXJRVmpd7tSiQy8UtRSU5a
         hiJp6kyUDTzNof4uM3TqvlEPCJz3k8dMXQu2o8xlqFX/DFvJjk0qZvVgtVELh/eEdF4n
         i5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769458712; x=1770063512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE7PtpLtQZOd0aAX87tJllaXQzvrrs347Pi8ubbeDQs=;
        b=uJNpv3m29yx17frKBiiaagefgQvK4aV0/FRmWVphVmGb31ugCq4fvr52TUER09+w9Y
         giwTFI81kZpTxhzoevOXihqmwIuxRhQHRuddpwgr5wY/wAsX2nVUZ+9BuGyv6bRB16AV
         Jg691OQ2pu4jjjqfdZWVCMJz1zUpsv6R/q6RV386ArxjO/iwycowi65h8ywCY7zSAttY
         GUK+j3Cp3qeNu9qnsnsXXb+P6ljr1tjdC8q4uuK2HxiYA4YYo+n9Gzk6KWqbx1m8kwSz
         Q3HOTYM6h/CjPONayuM1YGRw4vb8TPhQgpHnfE04xrBF4NFIV1WmvvM04qzwxxggjE1V
         tqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXwoSEYx5mK28k/y7r8x1+IGmY0Ta8nnSCcPgQ7I0yBEYKxWd1ci5ZsFngoqCfmcLHwc2CwYABOT9+uir/@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6gQmptHL8Oe39wkjAXSJuDJQbmkCEBrsUpUFFZhwjY4091Cs
	bH5qAXtGzYJ1hhCys9rck6njy6eZl6cVsRHNFArwlW7MY3fplm/RcgkeMH9bHx0ldV++i8KuPvo
	Z1KAc2DGgM38S4KWJZYP1jWJVwVHiqV3T2AAwvSvPSN34trk+CYddfHXFQ8AZs43Go6k=
X-Gm-Gg: AZuq6aI9sV+dsVrD3ntYl0ep6uybQxhM4o2XzNVICdOfihflCkYSQdp95H1CizdgOH8
	sPeT1F63RlOBP2CfNS5DA9qM5zpS1CpJ69x0jtuU8FuI0kQ+pOg1eVpq1DYJLr2tW9cMUH4Jlpu
	IhPXR7VWogUDEhi+4cdgLvG21zODA6F2TiVZyI+O7CXVC8iF5NX+Qwn7eoQ0G/yjlHbkFZw570z
	UtPTWX7qKSELPLcWP0jHIuQgVa8rU9/kNQ1Vf+SSpCkOjsFtirkTZShnN86AzNYn8paMj4YpQWG
	PmwFEtTBe7fjhPtF++vBbd/1Fu2lf0tTNxCZ8DLJdAvS8KIxhpJ/4Xxz4DGhswWnndfPe3tbLNX
	3f+niUr/sBjDPR3pvk2PAm9eZ49bT8BlJZLwOGqaN
X-Received: by 2002:a05:690c:398:b0:794:77da:aa55 with SMTP id 00721157ae682-79477daae97mr1230257b3.42.1769458712143;
        Mon, 26 Jan 2026 12:18:32 -0800 (PST)
X-Received: by 2002:a05:690c:398:b0:794:77da:aa55 with SMTP id 00721157ae682-79477daae97mr1230007b3.42.1769458711601;
        Mon, 26 Jan 2026 12:18:31 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2d060esm51355067b3.56.2026.01.26.12.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:18:31 -0800 (PST)
Message-ID: <3e4c420c7dd63ac3ecd0c9c21aea4f75784eada4.camel@redhat.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, pdonnell@redhat.com, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, khiremat@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Date: Mon, 26 Jan 2026 12:18:29 -0800
In-Reply-To: <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
References: <20260114195524.1025067-2-slava@dubeyko.com>
	 <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-75528-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email]
X-Rspamd-Queue-Id: 207FD8CF8D
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 13:35 +0100, Ilya Dryomov wrote:
> On Wed, Jan 14, 2026 at 8:56=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The CephFS kernel client has regression starting from 6.18-rc1.
> >=20
> > sudo ./check -g quick
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYN=
AMIC Fri
> > Nov 14 11:26:14 PST 2025
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch
> > /mnt/cephfs/scratch
> >=20
> > Killed
> >=20
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > (2)192.168.1.213:3300 session established
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL point=
er
> > dereference, address: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read a=
ccess in
> > kernel mode
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000=
) - not-
> > present page
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] =
SMP KASAN
> > NOPTI
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 345=
3 Comm:
> > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU St=
andard PC
> > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > ceph_mds_check_access+0x348/0x1760
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > __kasan_check_write+0x14/0x30
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x=
170
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > __pfx_apparmor_file_open+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > __ceph_caps_issued_mask_metric+0xd6/0x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/=
0x10e0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x=
50a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0=
x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > __pfx_stack_trace_save+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > stack_depot_save_flags+0x28/0x8f0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0x=
e/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x=
450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+=
0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d=
/0x2b0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > __check_object_size+0x453/0x600
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0x=
e/0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0=
x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > __pfx_do_sys_openat2+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x10=
8/0x240
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > __pfx___x64_sys_openat+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > __pfx___handle_mm_fault+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0=
x2350
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0x=
d50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/=
0xd50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > count_memcg_events+0x25b/0x400
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x3=
8b/0x6a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > irqentry_exit_to_user_mode+0x2e/0x2a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/=
0x50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95=
/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145=
ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3=
d 00 00
> > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c=
 ff ff ff
> > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 =
28 64 48
> > 2b 14 25
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d3=
16d0
> > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda =
RBX:
> > 0000000000000002 RCX: 000074a85bf145ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 =
RSI:
> > 00007ffc77d32789 RDI: 00000000ffffff9c
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 =
R08:
> > 00007ffc77d31980 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 =
R11:
> > 0000000000000246 R12: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff =
R14:
> > 0000000000000180 R15: 0000000000000001
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pm=
c_core
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_v=
sec
> > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesn=
i_intel
> > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgas=
tate
> > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc p=
pdev lp
> > parport efi_pstore
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000=
000000000
> > ]---
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> >=20
> > We have issue here [1] if fs_name =3D=3D NULL:
> >=20
> > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> >     ...
> >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> >             / fsname mismatch, try next one */
> >             return 0;
> >     }
> >=20
> > v2
> > Patrick Donnelly suggested that: In summary, we should definitely start
> > decoding `fs_name` from the MDSMap and do strict authorizations checks
> > against it. Note that the `--mds_namespace` should only be used for
> > selecting the file system to mount and nothing else. It's possible
> > no mds_namespace is specified but the kernel will mount the only
> > file system that exists which may have name "foo".
> >=20
> > v3
> > The namespace_equals() logic has been generalized into
> > __namespace_equals() with the goal of using it in
> > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> >=20
> > v4
> > The __namespace_equals() now supports wildcard check.
> >=20
> > v5
> > Patrick Donnelly suggested to add the sanity check of
> > kstrdup() returned pointer in ceph_mdsmap_decode()
> > added logic. Also, he suggested much simpler logic of
> > namespace strings comparison in the form of
> > ceph_namespace_match() logic.
> >=20
> > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > contains m_fs_name field that receives copy of extracted FS name
> > by ceph_extract_encoded_string(). For the case of "old" CephFS file sys=
tems,
> > it is used "cephfs" name. Also, namespace_equals() method has been
> > reworked with the goal of proper names comparison.
> >=20
> > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_clien=
t.c#L5666
> > [2] https://tracker.ceph.com/issues/73886
> >=20
> > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/mds_client.c         | 11 +++++------
> >  fs/ceph/mdsmap.c             | 24 ++++++++++++++++++------
> >  fs/ceph/mdsmap.h             |  1 +
> >  fs/ceph/super.h              | 24 +++++++++++++++++++-----
> >  include/linux/ceph/ceph_fs.h |  6 ++++++
> >  5 files changed, 49 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 7e4eab824dae..703c14bc3c95 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> >         struct ceph_client *cl =3D mdsc->fsc->client;
> > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace=
;
> > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> >         const char *spath =3D mdsc->fsc->mount_options->server_path;
> >         bool gid_matched =3D false;
> >         u32 gid, tlen, len;
> > @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >=20
> >         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
> >               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)=
) {
> > +
> > +       if (!ceph_namespace_match(auth->match.fs_name, fs_name, NAME_MA=
X)) {
>=20
> Hi Slava,
>=20
> How was this tested?  In particular, do you have a test case covering
> an MDS auth cap that specifies a particular fs_name (i.e. one where
> auth->match.fs_name wouldn't be NULL or CEPH_NAMESPACE_WILDCARD)?
>=20
> I'm asking because it looks like ceph_namespace_match() would always
> declare a mismatch in that scenario due to the fact that NAME_MAX is
> passed for target_len and
>=20
>     if (strlen(pattern) !=3D target_len)
>             return false;
>=20
> condition inside of ceph_namespace_match().  This in turn means that
> ceph_mds_check_access() would disregard the respective cap and might
> allow access where it's supposed to be denied.
>=20
>=20

I have run the xfstests (quick group) with the patch applied. I didn't see =
any
unusual behavior. If we believe that these tests are not enough, then, mayb=
e, we
need to introduce the additional Ceph specialized tests.

Thanks,
Slava.


