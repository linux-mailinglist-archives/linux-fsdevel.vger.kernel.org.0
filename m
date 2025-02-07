Return-Path: <linux-fsdevel+bounces-41230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8220DA2C944
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253571882DDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381118DB3B;
	Fri,  7 Feb 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pm0W84B9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lmTXrP5H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pm0W84B9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lmTXrP5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B818DB2A;
	Fri,  7 Feb 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946980; cv=none; b=QGYtj3HVbDlmPzg0QHdv6mIsC74tnwOvtJG0xIrH7SSzC7QUT3tHn80BZyCuE8fsF9a71N8Nlh+ALW08f+qKYYSYeQPU2oMGOTrkvzlAyYU9Sk/YTJTXao49PlwVZhdo1jcVhQxl+UVCwdkFiGzdD174m1S78MJgjokwug7v6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946980; c=relaxed/simple;
	bh=xZmqffqDVQ8mKlCsq9CGULFKDcvw4uoiRpd5c6in3pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKkvAp9OrcXLE+KuQ+592r9W9PwTnzL0hvuCLrASqWpTEO5SJ6lGX31PTwKZ5boOkV6xJygLqldzrU62GCkNELT29/fOeXI801h+1ree5dZCd1965AEs02c3GOAqxSETpMzHP3UZbUKxe7xlSQao6bvqeLiGmDQYdulm47nVaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pm0W84B9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lmTXrP5H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pm0W84B9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lmTXrP5H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8945F1F385;
	Fri,  7 Feb 2025 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738946975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyqD/CxZ5kQPMRrE3hkxQePERwOas13xWcXm+fbbgyc=;
	b=Pm0W84B9iWiffkLvxS7HygiT+LF0SHWBvqAoDup6BkBwF4fd75Xep3sEDa9hDd+M2xiASD
	XQHKROvqsRxR/1vKGauitJt8yOe7KOkxoqhCxyo9+EzFWQRbbvVgpLTM0+BkqMoYOSuMPq
	cH9JqlAPx2oeRjYsGJuZkKfTXOMNACU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738946975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyqD/CxZ5kQPMRrE3hkxQePERwOas13xWcXm+fbbgyc=;
	b=lmTXrP5H0jdfcwdlmUPPEvkNoDGwMt9a8t1JMn2Uxn6qjj6bnncSztBhIHtauqc1SOjQJ6
	New0jwo5iSwYw9Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738946975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyqD/CxZ5kQPMRrE3hkxQePERwOas13xWcXm+fbbgyc=;
	b=Pm0W84B9iWiffkLvxS7HygiT+LF0SHWBvqAoDup6BkBwF4fd75Xep3sEDa9hDd+M2xiASD
	XQHKROvqsRxR/1vKGauitJt8yOe7KOkxoqhCxyo9+EzFWQRbbvVgpLTM0+BkqMoYOSuMPq
	cH9JqlAPx2oeRjYsGJuZkKfTXOMNACU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738946975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyqD/CxZ5kQPMRrE3hkxQePERwOas13xWcXm+fbbgyc=;
	b=lmTXrP5H0jdfcwdlmUPPEvkNoDGwMt9a8t1JMn2Uxn6qjj6bnncSztBhIHtauqc1SOjQJ6
	New0jwo5iSwYw9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E0CA139CB;
	Fri,  7 Feb 2025 16:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOtgGp85pmcyZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Feb 2025 16:49:35 +0000
Message-ID: <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
Date: Fri, 7 Feb 2025 17:49:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>, Christian Heusel <christian@heusel.eu>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[toxicpanda.com,redhat.com,lists.linux.dev,vger.kernel.org,gmail.com,infradead.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/7/25 10:34, Miklos Szeredi wrote:
> [Adding Joanne, Willy and linux-mm].
>=20
>=20
> On Thu, 6 Feb 2025 at 11:54, Christian Heusel <christian@heusel.eu> wro=
te:
>>
>> Hello everyone,
>>
>> we have recently received [a report][0] on the Arch Linux Gitlab about=

>> multiple users having system crashes when using Flatpak programs and
>> related FUSE errors in their dmesg logs.
>>
>> We have subsequently bisected the issue within the mainline kernel tre=
e
>> to the following commit:
>>
>>     3eab9d7bc2f4 ("fuse: convert readahead to use folios")

I see that commit removes folio_put() from fuse_readpages_end(). Also it =
now
uses readahead_folio() in fuse_readahead() which does folio_put(). So tha=
t's
suspicious to me. It might be storing pointers to pages to ap->pages with=
out
pinning them with a refcount.

But I don't understand the code enough to know what's the proper fix. A
probably stupid fix would be to use __readahead_folio() instead and keep =
the
folio_put() in fuse_readpages_end().

>>
>> The error is still present in the latest mainline release 6.14-rc1 and=

>> sadly testing a revert is not trivially possible due to conflicts.
>>
>> I have attached a dmesg output from a boot where the failure occurs an=
d
>> I'm happy to test any debug patches with the help of the other reporte=
rs
>> on our GitLab.
>>
>> We also noticed that there already was [a discussion][1] about a relat=
ed
>> commit but the fix for the issue back then 7a4f54187373 ("fuse: fix
>> direct io folio offset and length calculation") was already included i=
n
>> the revisions we have tested.
>>
>> Cheers,
>> Christian
>>
>> [0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-=
/issues/110
>> [1]: https://lore.kernel.org/all/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgm=
bewvo674f7f3y@cwnwffjqltzw/
>=20
> Thanks for the report.
>=20
> Seems like page allocation gets an inconsistent page (mapcount !=3D -1)=

> in the report below.
>=20
> Any ideas why this could be happening?
>=20
> Thanks,
> Miklos
>=20
>> Feb 06 08:54:47 archvm kernel: BUG: Bad page state in process rnote  p=
fn:67587
>> Feb 06 08:54:47 archvm kernel: page: refcount:-1 mapcount:0 mapping:00=
00000000000000 index:0x0 pfn:0x67587
>> Feb 06 08:54:47 archvm kernel: flags: 0xfffffc8000020(lru|node=3D0|zon=
e=3D1|lastcpupid=3D0x1fffff)
>> Feb 06 08:54:47 archvm kernel: raw: 000fffffc8000020 dead000000000100 =
dead000000000122 0000000000000000
>> Feb 06 08:54:47 archvm kernel: raw: 0000000000000000 0000000000000000 =
ffffffffffffffff 0000000000000000
>> Feb 06 08:54:47 archvm kernel: page dumped because: PAGE_FLAGS_CHECK_A=
T_PREP flag(s) set
>> Feb 06 08:54:47 archvm kernel: Modules linked in: snd_seq_dummy snd_hr=
timer snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_co=
mmon kvm_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel s=
nd_intel_dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_=
hda_core polyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ss=
se3 intel_pmc_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ss=
se3 snd_timer aesni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr =
i2c_smbus soundcore lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_=
mod nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_=
vmci_transport vsock vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 m=
bcache jbd2 nouveau drm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_g=
puvm serio_raw drm_exec atkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display=
_helper virtio_net net_failover cec intel_agp virtio_input virtio_rng vir=
tio_console failover virtio_blk i8042 intel_gtt serio
>> Feb 06 08:54:47 archvm kernel: CPU: 0 UID: 1000 PID: 1962 Comm: rnote =
Not tainted 6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef3209cee42e97=
ae1c
>> Feb 06 08:54:47 archvm kernel: Hardware name: QEMU Standard PC (Q35 + =
ICH9, 2009), BIOS unknown 02/02/2022
>> Feb 06 08:54:47 archvm kernel: Call Trace:
>> Feb 06 08:54:47 archvm kernel:
>> Feb 06 08:54:47 archvm kernel:  dump_stack_lvl+0x5d/0x80
>> Feb 06 08:54:47 archvm kernel:  bad_page.cold+0x7a/0x91
>> Feb 06 08:54:47 archvm kernel:  __rmqueue_pcplist+0x200/0xc50
>> Feb 06 08:54:47 archvm kernel:  get_page_from_freelist+0x2ae/0x1740
>> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:54:47 archvm kernel:  ? __pm_runtime_suspend+0x69/0xc0
>> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:54:47 archvm kernel:  ? __seccomp_filter+0x303/0x520
>> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:54:47 archvm kernel:  __alloc_frozen_pages_noprof+0x184/0x33=
0
>> Feb 06 08:54:47 archvm kernel:  alloc_pages_mpol+0x7d/0x160
>> Feb 06 08:54:47 archvm kernel:  folio_alloc_mpol_noprof+0x14/0x40
>> Feb 06 08:54:47 archvm kernel:  vma_alloc_folio_noprof+0x69/0xb0
>> Feb 06 08:54:47 archvm kernel:  do_anonymous_page+0x32a/0x8b0
>> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:54:47 archvm kernel:  ? ___pte_offset_map+0x1b/0x180
>> Feb 06 08:54:47 archvm kernel:  __handle_mm_fault+0xb5e/0xfe0
>> Feb 06 08:54:47 archvm kernel:  handle_mm_fault+0xe2/0x2c0
>> Feb 06 08:54:47 archvm kernel:  do_user_addr_fault+0x217/0x620
>> Feb 06 08:54:47 archvm kernel:  exc_page_fault+0x81/0x1b0
>> Feb 06 08:54:47 archvm kernel:  asm_exc_page_fault+0x26/0x30
>> Feb 06 08:54:47 archvm kernel: RIP: 0033:0x7fcfc31c8cf9
>> Feb 06 08:54:47 archvm kernel: Code: 34 19 49 39 d4 49 89 74 24 60 0f =
95 c2 48 29 d8 48 83 c1 10 0f b6 d2 48 83 c8 01 48 c1 e2 02 48 09 da 48 8=
3 ca 01 48 89 51 f8 <48> 89 46 08 e9 22 ff ff ff 48 8d 3d 07 ed 10 00 e8 =
62 c3 ff ff 48
>> Feb 06 08:54:47 archvm kernel: RSP: 002b:00007fff1f931850 EFLAGS: 0001=
0206
>> Feb 06 08:54:47 archvm kernel: RAX: 000000000000bee1 RBX: 000000000000=
0140 RCX: 000056541d491ff0
>> Feb 06 08:54:47 archvm kernel: RDX: 0000000000000141 RSI: 000056541d49=
2120 RDI: 0000000000000000
>> Feb 06 08:54:47 archvm kernel: RBP: 00007fff1f9318a0 R08: 000000000000=
0140 R09: 0000000000000001
>> Feb 06 08:54:47 archvm kernel: R10: 0000000000000004 R11: 000056541956=
7488 R12: 00007fcfc3308ac0
>> Feb 06 08:54:47 archvm kernel: R13: 0000000000000130 R14: 00007fcfc330=
8b20 R15: 0000000000000140
>> Feb 06 08:54:47 archvm kernel:
>> Feb 06 08:54:47 archvm kernel: Disabling lock debugging due to kernel =
taint
>> Feb 06 08:54:47 archvm kernel: Oops: general protection fault, probabl=
y for non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOP=
TI
>> Feb 06 08:54:47 archvm kernel: CPU: 0 UID: 1000 PID: 1962 Comm: rnote =
Tainted: G    B              6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3=
178ef3209cee42e97ae1c
>> Feb 06 08:54:47 archvm kernel: Tainted: [B]=3DBAD_PAGE
>> Feb 06 08:54:47 archvm kernel: Hardware name: QEMU Standard PC (Q35 + =
ICH9, 2009), BIOS unknown 02/02/2022
>> Feb 06 08:54:47 archvm kernel: RIP: 0010:__rmqueue_pcplist+0xb0/0xc50
>> Feb 06 08:54:47 archvm kernel: Code: 00 4c 01 f0 48 89 7c 24 30 48 89 =
44 24 20 49 8b 04 24 49 39 c4 0f 84 6c 01 00 00 49 8b 14 24 48 8b 42 08 4=
8 8b 0a 48 8d 5a f8 <48> 3b 10 0f 85 8d 0b 00 00 48 3b 51 08 0f 85 d5 0f =
be ff 48 89 41
>> Feb 06 08:54:47 archvm kernel: RSP: 0000:ffffab3b84a2faa0 EFLAGS: 0001=
0297
>> Feb 06 08:54:47 archvm kernel: RAX: dead000000000122 RBX: ffffdd38819d=
61c0 RCX: dead000000000100
>> Feb 06 08:54:47 archvm kernel: RDX: ffffdd38819d61c8 RSI: ffff9b31fd22=
18c0 RDI: ffff9b31fd2218c0
>> Feb 06 08:54:47 archvm kernel: RBP: 0000000000000010 R08: 000000000000=
0000 R09: ffffab3b84a2f920
>> Feb 06 08:54:47 archvm kernel: R10: ffffffffbdeb44a8 R11: 000000000000=
0003 R12: ffff9b31fd23d4b0
>> Feb 06 08:54:47 archvm kernel: R13: 0000000000000000 R14: ffff9b31fef2=
1980 R15: ffff9b31fd23d480
>> Feb 06 08:54:47 archvm kernel: FS:  00007fcfbead5140(0000) GS:ffff9b31=
fd200000(0000) knlGS:0000000000000000
>> Feb 06 08:54:47 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
>> Feb 06 08:54:47 archvm kernel: CR2: 000056541d492128 CR3: 000000001ed9=
4000 CR4: 00000000003506f0
>> Feb 06 08:54:47 archvm kernel: Call Trace:
>> Feb 06 08:54:47 archvm kernel:
>> Feb 06 08:54:47 archvm kernel:  ? __die_body.cold+0x19/0x27
>> Feb 06 08:54:47 archvm kernel:  ? die_addr+0x3c/0x60
>> Feb 06 08:54:47 archvm kernel:  ? exc_general_protection+0x17d/0x400
>> Feb 06 08:54:47 archvm kernel:  ? asm_exc_general_protection+0x26/0x30=

>> Feb 06 08:54:47 archvm kernel:  ? __rmqueue_pcplist+0xb0/0xc50
>> Feb 06 08:54:47 archvm kernel:  get_page_from_freelist+0x2ae/0x1740
>> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:54:47 archvm kernel:  ? __pm_runtime_suspend+0x69/0xc0
>> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:54:47 archvm kernel:  ? __seccomp_filter+0x303/0x520
>> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:54:47 archvm kernel:  __alloc_frozen_pages_noprof+0x184/0x33=
0
>> Feb 06 08:54:47 archvm kernel:  alloc_pages_mpol+0x7d/0x160
>> Feb 06 08:54:47 archvm kernel:  folio_alloc_mpol_noprof+0x14/0x40
>> Feb 06 08:54:47 archvm kernel:  vma_alloc_folio_noprof+0x69/0xb0
>> Feb 06 08:54:47 archvm kernel:  do_anonymous_page+0x32a/0x8b0
>> Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:54:47 archvm kernel:  ? ___pte_offset_map+0x1b/0x180
>> Feb 06 08:54:47 archvm kernel:  __handle_mm_fault+0xb5e/0xfe0
>> Feb 06 08:54:47 archvm kernel:  handle_mm_fault+0xe2/0x2c0
>> Feb 06 08:54:47 archvm kernel:  do_user_addr_fault+0x217/0x620
>> Feb 06 08:54:47 archvm kernel:  exc_page_fault+0x81/0x1b0
>> Feb 06 08:54:47 archvm kernel:  asm_exc_page_fault+0x26/0x30
>> Feb 06 08:54:47 archvm kernel: RIP: 0033:0x7fcfc31c8cf9
>> Feb 06 08:54:47 archvm kernel: Code: 34 19 49 39 d4 49 89 74 24 60 0f =
95 c2 48 29 d8 48 83 c1 10 0f b6 d2 48 83 c8 01 48 c1 e2 02 48 09 da 48 8=
3 ca 01 48 89 51 f8 <48> 89 46 08 e9 22 ff ff ff 48 8d 3d 07 ed 10 00 e8 =
62 c3 ff ff 48
>> Feb 06 08:54:47 archvm kernel: RSP: 002b:00007fff1f931850 EFLAGS: 0001=
0206
>> Feb 06 08:54:47 archvm kernel: RAX: 000000000000bee1 RBX: 000000000000=
0140 RCX: 000056541d491ff0
>> Feb 06 08:54:47 archvm kernel: RDX: 0000000000000141 RSI: 000056541d49=
2120 RDI: 0000000000000000
>> Feb 06 08:54:47 archvm kernel: RBP: 00007fff1f9318a0 R08: 000000000000=
0140 R09: 0000000000000001
>> Feb 06 08:54:47 archvm kernel: R10: 0000000000000004 R11: 000056541956=
7488 R12: 00007fcfc3308ac0
>> Feb 06 08:54:47 archvm kernel: R13: 0000000000000130 R14: 00007fcfc330=
8b20 R15: 0000000000000140
>> Feb 06 08:54:47 archvm kernel:
>> Feb 06 08:54:47 archvm kernel: Modules linked in: snd_seq_dummy snd_hr=
timer snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_co=
mmon kvm_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel s=
nd_intel_dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_=
hda_core polyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ss=
se3 intel_pmc_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ss=
se3 snd_timer aesni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr =
i2c_smbus soundcore lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_=
mod nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_=
vmci_transport vsock vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 m=
bcache jbd2 nouveau drm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_g=
puvm serio_raw drm_exec atkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display=
_helper virtio_net net_failover cec intel_agp virtio_input virtio_rng vir=
tio_console failover virtio_blk i8042 intel_gtt serio
>> Feb 06 08:54:47 archvm kernel: ---[ end trace 0000000000000000 ]---
>> Feb 06 08:54:47 archvm kernel: RIP: 0010:__rmqueue_pcplist+0xb0/0xc50
>> Feb 06 08:54:47 archvm kernel: Code: 00 4c 01 f0 48 89 7c 24 30 48 89 =
44 24 20 49 8b 04 24 49 39 c4 0f 84 6c 01 00 00 49 8b 14 24 48 8b 42 08 4=
8 8b 0a 48 8d 5a f8 <48> 3b 10 0f 85 8d 0b 00 00 48 3b 51 08 0f 85 d5 0f =
be ff 48 89 41
>> Feb 06 08:54:47 archvm kernel: RSP: 0000:ffffab3b84a2faa0 EFLAGS: 0001=
0297
>> Feb 06 08:54:47 archvm kernel: RAX: dead000000000122 RBX: ffffdd38819d=
61c0 RCX: dead000000000100
>> Feb 06 08:54:47 archvm kernel: RDX: ffffdd38819d61c8 RSI: ffff9b31fd22=
18c0 RDI: ffff9b31fd2218c0
>> Feb 06 08:54:47 archvm kernel: RBP: 0000000000000010 R08: 000000000000=
0000 R09: ffffab3b84a2f920
>> Feb 06 08:54:47 archvm kernel: R10: ffffffffbdeb44a8 R11: 000000000000=
0003 R12: ffff9b31fd23d4b0
>> Feb 06 08:54:47 archvm kernel: R13: 0000000000000000 R14: ffff9b31fef2=
1980 R15: ffff9b31fd23d480
>> Feb 06 08:54:47 archvm kernel: FS:  00007fcfbead5140(0000) GS:ffff9b31=
fd200000(0000) knlGS:0000000000000000
>> Feb 06 08:54:47 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
>> Feb 06 08:54:47 archvm kernel: CR2: 000056541d492128 CR3: 000000001ed9=
4000 CR4: 00000000003506f0
>> Feb 06 08:54:47 archvm kernel: note: rnote[1962] exited with preempt_c=
ount 2
>> Feb 06 08:54:50 archvm geoclue[844]: Service not used for 60 seconds. =
Shutting down..
>> Feb 06 08:55:01 archvm systemd[990]: Starting Virtual filesystem metad=
ata service...
>> Feb 06 08:55:14 archvm kernel: watchdog: BUG: soft lockup - CPU#0 stuc=
k for 26s! [kworker/0:3:370]
>> Feb 06 08:55:14 archvm kernel: CPU#0 Utilization every 4s during locku=
p:
>> Feb 06 08:55:14 archvm kernel:         #1: 100% system,          0% so=
ftirq,          1% hardirq,          0% idle
>> Feb 06 08:55:14 archvm kernel:         #2: 100% system,          0% so=
ftirq,          1% hardirq,          0% idle
>> Feb 06 08:55:14 archvm kernel:         #3: 100% system,          0% so=
ftirq,          1% hardirq,          0% idle
>> Feb 06 08:55:14 archvm kernel:         #4: 100% system,          0% so=
ftirq,          1% hardirq,          0% idle
>> Feb 06 08:55:14 archvm kernel:         #5: 100% system,          0% so=
ftirq,          1% hardirq,          0% idle
>> Feb 06 08:55:14 archvm kernel: Modules linked in: snd_seq_dummy snd_hr=
timer snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_co=
mmon kvm_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel s=
nd_intel_dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_=
hda_core polyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ss=
se3 intel_pmc_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ss=
se3 snd_timer aesni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr =
i2c_smbus soundcore lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_=
mod nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_=
vmci_transport vsock vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 m=
bcache jbd2 nouveau drm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_g=
puvm serio_raw drm_exec atkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display=
_helper virtio_net net_failover cec intel_agp virtio_input virtio_rng vir=
tio_console failover virtio_blk i8042 intel_gtt serio
>> Feb 06 08:55:14 archvm kernel: CPU: 0 UID: 0 PID: 370 Comm: kworker/0:=
3 Tainted: G    B D            6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18=
e3178ef3209cee42e97ae1c
>> Feb 06 08:55:14 archvm kernel: Tainted: [B]=3DBAD_PAGE, [D]=3DDIE
>> Feb 06 08:55:14 archvm kernel: Hardware name: QEMU Standard PC (Q35 + =
ICH9, 2009), BIOS unknown 02/02/2022
>> Feb 06 08:55:14 archvm kernel: Workqueue: mm_percpu_wq vmstat_update
>> Feb 06 08:55:14 archvm kernel: RIP: 0010:__pv_queued_spin_lock_slowpat=
h+0x267/0x490
>> Feb 06 08:55:14 archvm kernel: Code: 14 0f 85 5c fe ff ff 41 c6 45 00 =
03 4c 89 fe 4c 89 ef e8 8c 2d 2e ff e9 47 fe ff ff f3 90 4d 8b 3e 4d 85 f=
f 74 f6 eb c1 f3 90 <83> ea 01 75 8a 48 83 3c 24 00 41 c6 45 01 00 0f 84 =
de 01 00 00 41
>> Feb 06 08:55:14 archvm kernel: RSP: 0018:ffffab3b80907c98 EFLAGS: 0000=
0206
>> Feb 06 08:55:14 archvm kernel: RAX: 0000000000000003 RBX: 000000000004=
0000 RCX: 0000000000000008
>> Feb 06 08:55:14 archvm kernel: RDX: 00000000000053b7 RSI: 000000000000=
0003 RDI: ffff9b31fd23d480
>> Feb 06 08:55:14 archvm kernel: RBP: 0000000000000001 R08: ffff9b31fd23=
7bc0 R09: 0000000000000000
>> Feb 06 08:55:14 archvm kernel: R10: 0000000000000000 R11: fefefefefefe=
feff R12: 0000000000000100
>> Feb 06 08:55:14 archvm kernel: R13: ffff9b31fd23d480 R14: ffff9b31fd23=
7bc0 R15: 0000000000000000
>> Feb 06 08:55:14 archvm kernel: FS:  0000000000000000(0000) GS:ffff9b31=
fd200000(0000) knlGS:0000000000000000
>> Feb 06 08:55:14 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
>> Feb 06 08:55:14 archvm kernel: CR2: 00007fa8ba718100 CR3: 000000001602=
2000 CR4: 00000000003506f0
>> Feb 06 08:55:14 archvm kernel: Call Trace:
>> Feb 06 08:55:14 archvm kernel:
>> Feb 06 08:55:14 archvm kernel:  ? watchdog_timer_fn.cold+0x226/0x22b
>> Feb 06 08:55:14 archvm kernel:  ? srso_return_thunk+0x5/0x5f
>> Feb 06 08:55:14 archvm kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
>> Feb 06 08:55:14 archvm kernel:  ? __hrtimer_run_queues+0x132/0x2a0
>> Feb 06 08:55:14 archvm kernel:  ? hrtimer_interrupt+0xff/0x230
>> Feb 06 08:55:14 archvm kernel:  ? __sysvec_apic_timer_interrupt+0x55/0=
x100
>> Feb 06 08:55:14 archvm kernel:  ? sysvec_apic_timer_interrupt+0x6c/0x9=
0
>> Feb 06 08:55:14 archvm kernel:
>> Feb 06 08:55:14 archvm kernel:
>> Feb 06 08:55:14 archvm kernel:  ? asm_sysvec_apic_timer_interrupt+0x1a=
/0x20
>> Feb 06 08:55:14 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267=
/0x490
>> Feb 06 08:55:14 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x2be=
/0x490
>> Feb 06 08:55:14 archvm kernel:  _raw_spin_lock+0x29/0x30
>> Feb 06 08:55:14 archvm kernel:  decay_pcp_high+0x63/0x90
>> Feb 06 08:55:14 archvm kernel:  refresh_cpu_vm_stats+0xf7/0x240
>> Feb 06 08:55:14 archvm kernel:  vmstat_update+0x13/0x50
>> Feb 06 08:55:14 archvm kernel:  process_one_work+0x17e/0x330
>> Feb 06 08:55:14 archvm kernel:  worker_thread+0x2ce/0x3f0
>> Feb 06 08:55:14 archvm kernel:  ? __pfx_worker_thread+0x10/0x10
>> Feb 06 08:55:14 archvm kernel:  kthread+0xef/0x230
>> Feb 06 08:55:14 archvm kernel:  ? __pfx_kthread+0x10/0x10
>> Feb 06 08:55:14 archvm kernel:  ret_from_fork+0x34/0x50
>> Feb 06 08:55:14 archvm kernel:  ? __pfx_kthread+0x10/0x10
>> Feb 06 08:55:14 archvm kernel:  ret_from_fork_asm+0x1a/0x30
>> Feb 06 08:55:14 archvm kernel:
>=20


