Return-Path: <linux-fsdevel+bounces-64346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 461A0BE2109
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39DF84E1F4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F49B3009F4;
	Thu, 16 Oct 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Dnh00I6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYFqVQPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A027732;
	Thu, 16 Oct 2025 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601589; cv=none; b=slpZ+gfzyyLb2AUx5qVArKvEVvCa1U6SrU2u2i0L45nYs7wsIywHQyT8ft1C4JnJWd7uzSBdnpMc+wh+allQ6p7+bbBtsA663oPauGWy6nBrWB0+AdHFqsqapUHVeihlnt5I8lBLYF1OOFXLu9O8Ks5AW1o4GQ8tHac4/NdDNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601589; c=relaxed/simple;
	bh=GLELI6edHgJ4rLrCFdN0EgSviGgY+6eg489je3IK53g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h4bqVzh3AO1yK/wfZBraJTYpHIyteQ2I4rnPGdAbRfX4TtbxDdocpYoVrMiid91e15IF8Im4Ps2jTJ1s0G8h6hCxovG4idJLAhSiPaWKPjj3JyeTgmiOZyEzRRatnIFkM4XFrcvw7WGpgxnx3KkIMYmLYgroTaZxa7gW4rGzpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Dnh00I6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYFqVQPa; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 15FA6130062E;
	Thu, 16 Oct 2025 03:59:45 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 16 Oct 2025 03:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760601584;
	 x=1760608784; bh=gsmN9Z3FJYObp60BofhTavDFXwdg3R8bCLb5lDfrp7M=; b=
	Dnh00I6kWVC+90tFamluJ46nm3D90eaqL0not1NLL0Cr+oHq1AUstzTsjXEufvBI
	NKe2r19Up1jt5g2erE0H9NZzSUsEwNbMW9FRXnxndtl3Lli4e2zbiP0AQv1EWoOD
	olKL334NBGt24dzX/MGdzVyc7CvR8cP0CZikzEQeB5ajsFcZR3snfokqT0SNLjBO
	KTPxZAhrqo6BPtJCpjGWLSnlXTYCQlH+qpbeHtMOz2u7RuDiBigtm6UIaOCo9AZ5
	rsR+zdgIPqAkCD3+fH5VfVEIVTZx+XlTE+gfyauocMOCekgftjlVYi3Qc+/iOsIw
	Qrtnbjr1vmobuL1Cb/1eDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760601584; x=
	1760608784; bh=gsmN9Z3FJYObp60BofhTavDFXwdg3R8bCLb5lDfrp7M=; b=J
	YFqVQPaF5TLM1U/Tn8/wz8rwBmZ3Rf1ciGLzKTV0RIzWA0trjMl+PvprizsQ3eQx
	EmPoEloHqDhEqFeYQuqcuMa0UihOKKujcw6Kag1LPuJ6awioecbMKklIRPpGGAlm
	Z/XOeWlGUtgS5sRTc+lPbYDU0CdkOqx8Mc1eRY6nuSDcNzys7BHhzsn2t1sDcNU4
	s/KclAErUxhVtaxcUjiDz67VQvQAuHap+gGqt3m6rIeRFfw1L65ihkmbxdYKh8B/
	A12xotHVXjZNTjw7HqOm5H6wDv6FzSAJc3okjrV5tnNyS7Sc1j8LjXcSGLveRDC/
	PUWvipCNKFttJGawk5P+g==
X-ME-Sender: <xms:7aXwaCh0KeFEB9Lz8Gt7Nxq4e_TdQu0NcmZkqq0Skmu5qnLvZHdcYQ>
    <xme:7aXwaN04cb3r_2ZICkRKRvQcS_SYVxXNnyB4RdbSZQfatj2ru8zRQTnJH2uBIAxyl
    BuhkOqSjhlQVJqi6DkrLV_Emt-lXcmIkxJKv5nYlLFDx3xU0UyzfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtoh
    hprdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhs
    rdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhgrrhhoqdhmmhdqshhigh
    eslhhishhtshdrlhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrhhtqdgu
    vghvvghlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghorhgsvghtse
    hlfihnrdhnvghtpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthho
    pehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepiihihiesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepuggrmhhivghnrdhlvghmohgrlhesohhpvghn
    shhouhhrtggvrdifuggtrdgtohhm
X-ME-Proxy: <xmx:7qXwaF73EL6Wx1oi645Jpe2lS5LjUOa0e0we3mKVQTSE3p0t5WtlcQ>
    <xmx:7qXwaF_SZMGZDLyxSroOVGRtH_rQbTm8j5j-1WoqVCGKOxiqi37MRw>
    <xmx:7qXwaKgQnzHzqlVSGnHM9v5A-eHyieFGElZzCzacMtdBaIymwbCU0g>
    <xmx:7qXwaBlI2bpTfBZIpc_5FEL5K34_sy966F03LOitDOOWHQPhpIbuUQ>
    <xmx:8KXwaBm8mD5l3EECvoNK0awzSPWIFuIwr0vxYRb-zAKqRTZQhRxc6xx7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C2CC7700063; Thu, 16 Oct 2025 03:59:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aghr8S2aY07B
Date: Thu, 16 Oct 2025 09:59:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
 linux-ide@vger.kernel.org, "Andreas Dilger" <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Sasha Levin" <sashal@kernel.org>,
 "Daniel Vetter" <daniel.vetter@ffwll.ch>, duyuyang@gmail.com,
 "Johannes Berg" <johannes.berg@intel.com>, "Tejun Heo" <tj@kernel.org>,
 "Theodore Ts'o" <tytso@mit.edu>, "Matthew Wilcox" <willy@infradead.org>,
 "Dave Chinner" <david@fromorbit.com>,
 "Amir Goldstein" <amir73il@gmail.com>, kernel-team@lge.com,
 linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Minchan Kim" <minchan@kernel.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
 "SeongJae Park" <sj@kernel.org>, jglisse@redhat.com,
 "Dennis Zhou" <dennis@kernel.org>, "Christoph Lameter" <cl@linux.com>,
 "Pekka Enberg" <penberg@kernel.org>,
 "David Rientjes" <rientjes@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, ngupta@vflare.org,
 linux-block@vger.kernel.org, "Josef Bacik" <josef@toxicpanda.com>,
 linux-fsdevel@vger.kernel.org, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Darrick J. Wong" <djwong@kernel.org>, dri-devel@lists.freedesktop.org,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, harry.yoo@oracle.com, chris.p.wilson@intel.com,
 "Gwan-gyeong Mun" <gwan-gyeong.mun@intel.com>,
 max.byungchul.park@gmail.com, "Boqun Feng" <boqun.feng@gmail.com>,
 "Waiman Long" <longman@redhat.com>, yunseong.kim@ericsson.com,
 ysk@kzalloc.com, "Yeoreum Yun" <yeoreum.yun@arm.com>,
 Netdev <netdev@vger.kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, her0gyugyu@gmail.com,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, gustavo@padovan.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Andi Shyti" <andi.shyti@kernel.org>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, da.gomez@kernel.org,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, qiang.zhang@linux.dev,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, neil@brown.name,
 okorniev@redhat.com, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, trondmy@kernel.org,
 "Anna Schumaker" <anna@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Clark Williams" <clrkwllms@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, ada.coupriediaz@arm.com,
 kristina.martsenko@arm.com, "Kefeng Wang" <wangkefeng.wang@huawei.com>,
 "Mark Brown" <broonie@kernel.org>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Zi Yan" <ziy@nvidia.com>,
 "Yu Zhao" <yuzhao@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, usamaarif642@gmail.com,
 joel.granados@kernel.org, "Wei Yang" <richard.weiyang@gmail.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 tim.c.chen@linux.intel.com, linux <linux@treblig.org>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 lillian@star-ark.net, "Huacai Chen" <chenhuacai@kernel.org>,
 francesco@valla.it, guoweikang.kernel@gmail.com, link@vivo.com,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Oleg Nesterov" <oleg@redhat.com>, "Mateusz Guzik" <mjguzik@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-modules@vger.kernel.org, rcu <rcu@vger.kernel.org>,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev
Message-Id: <6241800d-9456-4d5f-b55d-611e33f2c446@app.fastmail.com>
In-Reply-To: <20251016004640.GB2948@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-2-byungchul@sk.com>
 <2025100230-grafted-alias-22a2@gregkh>
 <63034035-03e4-4184-afce-7e1a897a90e9@efficios.com>
 <3bbe14af-ccdc-4c78-a7ca-d4ed39fa6b5d@app.fastmail.com>
 <20251016004640.GB2948@system.software.com>
Subject: Re: [PATCH v17 01/47] llist: move llist_{head,node} definition to types.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 16, 2025, at 02:46, Byungchul Park wrote:
> On Fri, Oct 03, 2025 at 01:19:33AM +0200, Arnd Bergmann wrote:
>> On Thu, Oct 2, 2025, at 15:53, Mathieu Desnoyers wrote:
>> > On 2025-10-02 04:24, Greg KH wrote:
>> >> On Thu, Oct 02, 2025 at 05:12:01PM +0900, Byungchul Park wrote:

>> Maybe a shared linux/list_types.h would work, to specifically
>
> I found a way to resolve my issue, but I thought it's good idea
> regardless of my issue and took a quick look.  However, it seems like
> there's an overwhelming amount of work since it might require to replace
> all the existing include <linux/types.h> for use of list things with the
> new one :-).

I don't think it's that bad, since almost every header ends up
including linux/list.h indirectly at the moment.

A little bit of scripting to find the headers that reference
'struct list_head' but don't also include linux/list.h reveals
this relatively short set that would need to include the new
header:

> include/keys/asymmetric-parser.h
> include/linux/dynamic_debug.h
> include/linux/genalloc.h
> include/linux/gpio/machine.h
> include/linux/hiddev.h
> include/linux/iio/iio-opaque.h
> include/linux/iio/sysfs.h
> include/linux/input/touch-overlay.h
> include/linux/irq_poll.h
> include/linux/iscsi_boot_sysfs.h
> include/linux/kcore.h
> include/linux/kcsan-checks.h
> include/linux/kcsan.h
> include/linux/lockdep_types.h
> include/linux/logic_pio.h
> include/linux/maple.h
> include/linux/mfd/iqs62x.h
> include/linux/mlx5/macsec.h
> include/linux/mount.h
> include/linux/mtd/map.h
> include/linux/mtd/nand-qpic-common.h
> include/linux/mtd/partitions.h
> include/linux/mutex_types.h
> include/linux/nfs_fs_i.h
> include/linux/of_iommu.h
> include/linux/parport_pc.h
> include/linux/pinctrl/pinctrl.h
> include/linux/plist_types.h
> include/linux/pm_wakeup.h
> include/linux/reboot-mode.h
> include/linux/shm.h
> include/linux/smpboot.h
> include/linux/sunrpc/xprtmultipath.h
> include/linux/usb/audio.h
> include/linux/workqueue_types.h
> include/linux/zpool.h
> include/net/bluetooth/hci_sync.h
> include/net/bluetooth/l2cap.h
> include/net/bluetooth/rfcomm.h
> include/net/dcbnl.h
> include/sound/i2c.h
> include/sound/soc-jack.h
> include/target/iscsi/iscsi_transport.h
> include/video/udlfb.h

A lot of these don't have any #include statements at all,
which indicates that they expect to only be included in
places where the dependencies are already visible.

      Arnd

