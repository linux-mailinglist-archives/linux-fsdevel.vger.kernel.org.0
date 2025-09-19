Return-Path: <linux-fsdevel+bounces-62210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBBB886CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABFF188A4AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1479306D58;
	Fri, 19 Sep 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="ABqjRV1d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182B3064A6;
	Fri, 19 Sep 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270628; cv=none; b=j2j0VcvZ1oDtATg4V0hD6+7UhJfSSCwxpD+JFMxcLj5RCv4WSXLeNtGY9IIRVGPwWkmJ+QSHXTpquUCPV+u+IwMuvwiEvBn1iJ490n1syI2URznWkc5HzAoAYLHFMVPeZfuasJpMvaiQbNO3XD9iJZFUk4k/PNqECHeAGns4Mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270628; c=relaxed/simple;
	bh=chycPGmzND4aV3mQWX3O8q+2iNT/S538T+FxSRYGFXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xco4ZgijlnjPdmpOZdZNFidM2dMZKuojQf6bnSTDoYrJHh2Zb3Lo9x9kUaatZPiVNvyxJPvDsEPZzFjm7OkdKppj5WD/GKy6UEDfZEWuPwYdpqysCt7BU+N70M7ERwdmscwykVI0q2WxtQRVNgtiHqkwT/E5jFNeDp6RPSKftMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=ABqjRV1d; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1758270626; x=1789806626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xQMfSE2j0e0kXW7iy6dzBiNtwDQyibH0F14unNsZxY0=;
  b=ABqjRV1dx9Xs8VV4tKDV0jKS3FTq8BQYilD5FJiYN4ufC1P4Ko0fv1Uj
   gU87yt4UDcBiMY1PJFjfnFMoovkYgmGDt4IeDSS5Bm2NOsVRi19EZRIcj
   I8145KYEqH7bnQD/hkRflo4qjsaXKpPU38kZDKWiW5zQQKI36wk3XWMn/
   ke4eAddoPATVNe3WMRzfKv5ir+yaBeHbr9t37qgPBuzV99rtm5PFrU5Ve
   IiHRWEvYkxaabR7x52ecogBr/Roxj/IGAkhRdQqjZp+jm9tQJ9nH2CXAL
   16nJe/Jir/83ZZBBFLHKattLTTTMBiafIAJhSqtgedFFigyjX3Fx1aB87
   g==;
X-CSE-ConnectionGUID: vUeZyQaIS32WfGrBH8LBqw==
X-CSE-MsgGUID: 7ubyqWN9R7CraB91GGKOuQ==
X-IronPort-AV: E=Sophos;i="6.18,277,1751241600"; 
   d="scan'208";a="2361382"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:30:09 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:2610]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.36.68:2525] with esmtp (Farcaster)
 id 2e1ccd73-6c97-437e-b0d8-729206f284fa; Fri, 19 Sep 2025 08:30:09 +0000 (UTC)
X-Farcaster-Flow-ID: 2e1ccd73-6c97-437e-b0d8-729206f284fa
Received: from EX19D015EUB002.ant.amazon.com (10.252.51.123) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 08:30:08 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB002.ant.amazon.com (10.252.51.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 08:30:08 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Fri, 19 Sep 2025 08:30:08 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
To: "hughd@google.com" <hughd@google.com>
CC: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "andrii@kernel.org" <andrii@kernel.org>, "anna@kernel.org"
	<anna@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"ast@kernel.org" <ast@kernel.org>, "axelrasmussen@google.com"
	<axelrasmussen@google.com>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "derekmn@amazon.co.uk"
	<derekmn@amazon.co.uk>, "devel@lists.orangefs.org"
	<devel@lists.orangefs.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "haoluo@google.com" <haoluo@google.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"hubcap@omnibond.com" <hubcap@omnibond.com>, "jack@suse.cz" <jack@suse.cz>,
	"Thomson, Jack" <jackabt@amazon.co.uk>, "jannh@google.com"
	<jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "luto@kernel.org"
	<luto@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"martin@omnibond.com" <martin@omnibond.com>, "maz@kernel.org"
	<maz@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "rppt@kernel.org" <rppt@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "seanjc@google.com" <seanjc@google.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, "shuah@kernel.org"
	<shuah@kernel.org>, "song@kernel.org" <song@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "trondmy@kernel.org" <trondmy@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "weixugc@google.com" <weixugc@google.com>,
	"will@kernel.org" <will@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "x86@kernel.org" <x86@kernel.org>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"yuanchu@google.com" <yuanchu@google.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 01/11] filemap: Pass address_space mapping to
 ->free_folio()
Thread-Topic: [PATCH v6 01/11] filemap: Pass address_space mapping to
 ->free_folio()
Thread-Index: AQHcKT+bvwDzyVs1WEGX2DXFZiV07Q==
Date: Fri, 19 Sep 2025 08:30:08 +0000
Message-ID: <20250919083006.21171-1-roypat@amazon.co.uk>
References: <7c2677e1-daf7-3b49-0a04-1efdf451379a@google.com>
In-Reply-To: <7c2677e1-daf7-3b49-0a04-1efdf451379a@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=0A=
Hi Hugh!=0A=
=0A=
On Tue, 2025-09-16 at 07:23 +0100, Hugh Dickins wrote:> On Fri, 12 Sep 2025=
, Roy, Patrick wrote:=0A=
> =0A=
>> From: Elliot Berman <quic_eberman@quicinc.com>=0A=
>>=0A=
>> When guest_memfd removes memory from the host kernel's direct map,=0A=
>> direct map entries must be restored before the memory is freed again. To=
=0A=
>> do so, ->free_folio() needs to know whether a gmem folio was direct map=
=0A=
>> removed in the first place though. While possible to keep track of this=
=0A=
>> information on each individual folio (e.g. via page flags), direct map=
=0A=
>> removal is an all-or-nothing property of the entire guest_memfd, so it=
=0A=
>> is less error prone to just check the flag stored in the gmem inode's=0A=
>> private data.  However, by the time ->free_folio() is called,=0A=
>> folio->mapping might be cleared. To still allow access to the address=0A=
>> space from which the folio was just removed, pass it in as an additional=
=0A=
>> argument to ->free_folio, as the mapping is well-known to all callers.=
=0A=
>>=0A=
>> Link: https://lore.kernel.org/all/15f665b4-2d33-41ca-ac50-fafe24ade32f@r=
edhat.com/=0A=
>> Suggested-by: David Hildenbrand <david@redhat.com>=0A=
>> Acked-by: David Hildenbrand <david@redhat.com>=0A=
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>=0A=
>> [patrick: rewrite shortlog for new usecase]=0A=
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>=0A=
>> ---=0A=
>>  Documentation/filesystems/locking.rst |  2 +-=0A=
>>  fs/nfs/dir.c                          | 11 ++++++-----=0A=
>>  fs/orangefs/inode.c                   |  3 ++-=0A=
>>  include/linux/fs.h                    |  2 +-=0A=
>>  mm/filemap.c                          |  9 +++++----=0A=
>>  mm/secretmem.c                        |  3 ++-=0A=
>>  mm/vmscan.c                           |  4 ++--=0A=
>>  virt/kvm/guest_memfd.c                |  3 ++-=0A=
>>  8 files changed, 21 insertions(+), 16 deletions(-)=0A=
>>=0A=
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/files=
ystems/locking.rst=0A=
>> index aa287ccdac2f..74c97287ec40 100644=0A=
>> --- a/Documentation/filesystems/locking.rst=0A=
>> +++ b/Documentation/filesystems/locking.rst=0A=
>> @@ -262,7 +262,7 @@ prototypes::=0A=
>>       sector_t (*bmap)(struct address_space *, sector_t);=0A=
>>       void (*invalidate_folio) (struct folio *, size_t start, size_t len=
);=0A=
>>       bool (*release_folio)(struct folio *, gfp_t);=0A=
>> -     void (*free_folio)(struct folio *);=0A=
>> +     void (*free_folio)(struct address_space *, struct folio *);=0A=
>>       int (*direct_IO)(struct kiocb *, struct iov_iter *iter);=0A=
>>       int (*migrate_folio)(struct address_space *, struct folio *dst,=0A=
>>                       struct folio *src, enum migrate_mode);=0A=
> =0A=
> Beware, that is against the intent of free_folio().=0A=
> =0A=
> Since its 2.6.37 origin in 6072d13c4293 ("Call the filesystem back=0A=
> whenever a page is removed from the page cache"), freepage() or=0A=
> free_folio() has intentionally NOT taken a struct address_space *mapping,=
=0A=
> because that structure may already be freed by the time free_folio() is=
=0A=
> called, if the last folio holding it has now been freed.=0A=
> =0A=
> Maybe something has changed since then, or maybe it happens to be safe=0A=
> just in the context in which you want to use it; but it is against the=0A=
> principle of free_folio().  (Maybe an rcu_read_lock() could be added=0A=
> in __remove_mapping() to make it safe nowadays? maybe not welcome.)=0A=
> =0A=
> See Documentation/filesystems/vfs.rst:=0A=
> free_folio is called once the folio is no longer visible in the=0A=
> page cache in order to allow the cleanup of any private data.=0A=
> Since it may be called by the memory reclaimer, it should not=0A=
> assume that the original address_space mapping still exists, and=0A=
> it should not block.=0A=
> =0A=
> Hugh=0A=
Thanks for pointing this out! I think I can make do without this patch,=0A=
by storing the direct map state in some bit directly on the folio (in=0A=
yesterday's upstream guest_memfd call, we talked about using=0A=
->private, which guest_memfd isn't using for anything yet). Will do that=0A=
for the next iteration.=0A=
=0A=
Best,=0A=
Patrick=0A=
=0A=

