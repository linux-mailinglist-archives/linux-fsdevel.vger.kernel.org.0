Return-Path: <linux-fsdevel+bounces-62599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE5B9AA8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43562E6D19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A330FC06;
	Wed, 24 Sep 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="e5akja/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88189307AFA;
	Wed, 24 Sep 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727759; cv=none; b=iYIUcMVcmqu7iveiWDNMvT6bW8+AhJ4sN1T9b0XYZaVVKQYl0MKPXHt4hkd4jtfGbNIDFqNznrfne17ckjI1D/n+oim9SEYhBLjgA0qoz2SS6dF60JW97k8NoGu5qJ2IUwNdY30bmuMBVSPPZOHBkvuiuSq4mubaOLV2v6u2M04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727759; c=relaxed/simple;
	bh=xYwtDKmp/Zq0jOTCpG7R8cZcsQAosKrhHZ6MWIe4xuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZWsJ6AKiLfKynqDA68uH8Zhj0ssVeGzKnUxSgnCD51hWKvsx+pm5J7H5b1SNzJi0512QxUpBne2IsKqrJAoTmgRwm0DREpzQ4Kk6oQKwJNBvdlIwEAyHYxHxMIPt5YMk+yBgAi47XzMcFs337vvaGvjOC2Lctnn7UVLf7Z2iRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=e5akja/T; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1758727757; x=1790263757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xYwtDKmp/Zq0jOTCpG7R8cZcsQAosKrhHZ6MWIe4xuU=;
  b=e5akja/TG+PPyD+foNY0somRRp9ihxaoJ85iYC5Q+8VPXAfBv6U+yWqI
   kGnIHm2WeCOodMOuWHTWxX/6ztHBr80Vsgr/ecFq3qTF7OYB9vU71L4yS
   E+S7hXDeynLF6XZJqqcRq/G4rriME+iK8s9gMHrJJNe+9Hc/wx/svd/ow
   /B3/xNoPo3M+EoGWBw+xySyqbiFI/0c9RRKbrlNfxYUK5fv7Gl8tQvOWF
   vPnqXiKLTzqNLO6B646obWPaj20Q8KE634lajOPoro7tXggQkI/odjD1D
   cdp1PDfso91LJztHYMhKPbtcyfQxIm5xd+N8W3ytq3AriWNMlyVdgJkrG
   g==;
X-CSE-ConnectionGUID: H1Nwja16SO+mJPPrYIM6Uw==
X-CSE-MsgGUID: 6BUVeHZ3T1iQWbqFFphHSA==
X-IronPort-AV: E=Sophos;i="6.18,290,1751241600"; 
   d="scan'208";a="2615965"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:29:14 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:7826]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.45.166:2525] with esmtp (Farcaster)
 id f979d79c-010c-49b7-9e97-d5be296685f6; Wed, 24 Sep 2025 15:29:14 +0000 (UTC)
X-Farcaster-Flow-ID: f979d79c-010c-49b7-9e97-d5be296685f6
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 15:29:13 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB004.ant.amazon.com (10.252.51.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 15:29:13 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Wed, 24 Sep 2025 15:29:13 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
To: "patrick.roy@campus.lmu.de" <patrick.roy@campus.lmu.de>
CC: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "andrii@kernel.org"
	<andrii@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "derekmn@amazon.co.uk"
	<derekmn@amazon.co.uk>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"haoluo@google.com" <haoluo@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"Thomson, Jack" <jackabt@amazon.co.uk>, "jannh@google.com"
	<jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "luto@kernel.org"
	<luto@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"maz@kernel.org" <maz@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "pfalcato@suse.de" <pfalcato@suse.de>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "rppt@kernel.org" <rppt@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "seanjc@google.com" <seanjc@google.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "song@kernel.org" <song@kernel.org>,
	"surenb@google.com" <surenb@google.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tabba@google.com" <tabba@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"will@kernel.org" <will@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "x86@kernel.org" <x86@kernel.org>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 00/12] Direct Map Removal Support for guest_memfd
Thread-Topic: [PATCH v7 00/12] Direct Map Removal Support for guest_memfd
Thread-Index: AQHcLWf7p6lrgf1yqEyGzQxUogXjVw==
Date: Wed, 24 Sep 2025 15:29:13 +0000
Message-ID: <20250924152912.11563-1-roypat@amazon.co.uk>
References: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
In-Reply-To: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
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

_sigh_=0A=
=0A=
I tried to submit this iteration from a personal email, because amazon's ma=
il=0A=
server was scrambling the "From" header and I couldn't figure out why (and =
also=0A=
because I am leaving Amazon next month and wanted replies to go into an inb=
ox=0A=
to which I'll continue to have access). And then after posting the first 4=
=0A=
emails I hit "daily mail quota exceeded", and had to submit the rest of the=
=0A=
patch series from the amazon email anyway. Sorry about the resulting mess (=
i=0A=
think the threading got slightly messed up as a result of this). I'll somet=
hing=0A=
else out for the next iteration.=0A=
=0A=

