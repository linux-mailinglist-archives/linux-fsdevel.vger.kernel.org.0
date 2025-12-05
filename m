Return-Path: <linux-fsdevel+bounces-70805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6821DCA6ECD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B253D31DE05B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAE32572D;
	Fri,  5 Dec 2025 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRrD1Ibi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926E3164D3;
	Fri,  5 Dec 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764926887; cv=none; b=BG46cNz3JwOs33ZpLgEv3YkN197PiWn4c0jY6s3ZndW0iTKepVbKLm0yUkpNS1b+Sq2cISr2yR4sH5CVLTUFsCsmNOv/J+aLK70saXpEh9/2fwlfZ0qNkLotjyjk3EQLYugBBTcKzlV/zfA8YXoruIMjwn8SXDmFZsd7DU/ZnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764926887; c=relaxed/simple;
	bh=/3K8i488KBtohoPjUWcmwxOuPxkVYp8UF2/iPAPxq7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lKw9+O+uy/86AULuO8cYBWv9WjJg32FgE8adnVGu+x0KUkv8vXjCALTH7R7Qm2KLjVWDLmFzt0F0BZ1i6zm90WF8asFEd0AwxKHzVhJ73sTnKBIVACqtPjRmrsj/H6mFSEtB3dD6YP6YWZkbDDBmU0QnuKPuZVuE0deb7pwnMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRrD1Ibi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F54C4CEF1;
	Fri,  5 Dec 2025 09:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764926885;
	bh=/3K8i488KBtohoPjUWcmwxOuPxkVYp8UF2/iPAPxq7Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YRrD1IbijzZtM+qkYdKqMCtJSY7HW/b2RS+RGwoFe9bPK/qWFg3n6jePfSjkEJ252
	 CAstxESV1t5hIfHaNpivukj3cMXOpAMg0/UqoCgsIZzotoaILL21oKFa9ikkMb7YNl
	 qqNVditrpYtGa7rGlqrjiS8gpKMFlw9u1U78kVXNQ6fZ18DGyDH2qOcSrxYOJtk1WN
	 dF0rZn265IWR71TmnUtnGq8SAs1Q/6QTETPixkqjPtVt06ZheKAgeGXqIyF47v2gee
	 2OnhEW5m8+31fx4RYUVZM3XYN7ukMj5estutAcl9/Ron0WYtClPzGLKIvzh03vv/vR
	 FOpwVUcjkVvvA==
Message-ID: <cd65b963dd4edade3afb2e7d27eb33af1c62682e.camel@kernel.org>
Subject: Re: [PATCH v18 41/42] SUNRPC: relocate struct rcu_head to the first
 field of struct rpc_xprt
From: Jeff Layton <jlayton@kernel.org>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org, 
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
 rostedt@goodmis.org, 	joel@joelfernandes.org, sashal@kernel.org,
 daniel.vetter@ffwll.ch, 	duyuyang@gmail.com, johannes.berg@intel.com,
 tj@kernel.org, tytso@mit.edu, 	willy@infradead.org, david@fromorbit.com,
 amir73il@gmail.com, 	gregkh@linuxfoundation.org, kernel-team@lge.com,
 linux-mm@kvack.org, 	akpm@linux-foundation.org, mhocko@kernel.org,
 minchan@kernel.org, 	hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 sj@kernel.org, jglisse@redhat.com, 	dennis@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, 	vbabka@suse.cz,
 ngupta@vflare.org, linux-block@vger.kernel.org, 	josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, 	dan.j.williams@intel.com,
 hch@infradead.org, djwong@kernel.org, 	dri-devel@lists.freedesktop.org,
 rodrigosiqueiramelo@gmail.com, 	melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, harry.yoo@oracle.com, 	chris.p.wilson@intel.com,
 gwan-gyeong.mun@intel.com, 	max.byungchul.park@gmail.com,
 boqun.feng@gmail.com, longman@redhat.com, 	yunseong.kim@ericsson.com,
 ysk@kzalloc.com, yeoreum.yun@arm.com, 	netdev@vger.kernel.org,
 matthew.brost@intel.com, her0gyugyu@gmail.com, 	corbet@lwn.net,
 catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	luto@kernel.org, sumit.semwal@linaro.org, gustavo@padovan.org, 
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, 	samitolvanen@google.com, paulmck@kernel.org,
 frederic@kernel.org, 	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, 	urezki@gmail.com, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, 	qiang.zhang@linux.dev, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, 	dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, 	chuck.lever@oracle.com,
 neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, 	tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, kees@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, mark.rutland@arm.com, 
	ada.coupriediaz@arm.com, kristina.martsenko@arm.com,
 wangkefeng.wang@huawei.com, 	broonie@kernel.org, kevin.brodsky@arm.com,
 dwmw@amazon.co.uk, 	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
 yuzhao@google.com, 	baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
 joel.granados@kernel.org, 	richard.weiyang@gmail.com,
 geert+renesas@glider.be, tim.c.chen@linux.intel.com, 	linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, 	thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, 	andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, 	linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, 	linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 2407018371@qq.com, 	dakr@kernel.org, miguel.ojeda.sandonis@gmail.com,
 neilb@ownmail.net, 	bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
 dave.hansen@intel.com, 	geert@linux-m68k.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, 	bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, 	aliceryhl@google.com,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org
Date: Fri, 05 Dec 2025 04:27:52 -0500
In-Reply-To: <20251205071855.72743-42-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
	 <20251205071855.72743-42-byungchul@sk.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 16:18 +0900, Byungchul Park wrote:
> While compiling Linux kernel with DEPT on, the following error was
> observed:
>=20
>    ./include/linux/rcupdate.h:1084:17: note: in expansion of macro
>    =E2=80=98BUILD_BUG_ON=E2=80=99
>    1084 | BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >=3D 4096);	\
>         | ^~~~~~~~~~~~
>    ./include/linux/rcupdate.h:1047:29: note: in expansion of macro
>    'kvfree_rcu_arg_2'
>    1047 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>         |                             ^~~~~~~~~~~~~~~~
>    net/sunrpc/xprt.c:1856:9: note: in expansion of macro 'kfree_rcu'
>    1856 | kfree_rcu(xprt, rcu);
>         | ^~~~~~~~~
>     CC net/kcm/kcmproc.o
>    make[4]: *** [scripts/Makefile.build:203: net/sunrpc/xprt.o] Error 1
>=20
> Since kfree_rcu() assumes 'offset of struct rcu_head in a rcu-managed
> struct < 4096', the offest of struct rcu_head in struct rpc_xprt should
> not exceed 4096 but does, due to the debug information added by DEPT.
>=20
> Relocate struct rcu_head to the first field of struct rpc_xprt from an
> arbitrary location to avoid the issue and meet the assumption.
>=20
> Reported-by: Yunseong Kim <ysk@kzalloc.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/sunrpc/xprt.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index f46d1fb8f71a..666e42a17a31 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -211,6 +211,14 @@ enum xprt_transports {
> =20
>  struct rpc_sysfs_xprt;
>  struct rpc_xprt {
> +	/*
> +	 * Place struct rcu_head within the first 4096 bytes of struct
> +	 * rpc_xprt if sizeof(struct rpc_xprt) > 4096, so that
> +	 * kfree_rcu() can simply work assuming that.  See the comment
> +	 * in kfree_rcu().
> +	 */
> +	struct rcu_head		rcu;
> +
>  	struct kref		kref;		/* Reference count */
>  	const struct rpc_xprt_ops *ops;		/* transport methods */
>  	unsigned int		id;		/* transport id */
> @@ -317,7 +325,6 @@ struct rpc_xprt {
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  	struct dentry		*debugfs;		/* debugfs directory */
>  #endif
> -	struct rcu_head		rcu;
>  	const struct xprt_class	*xprt_class;
>  	struct rpc_sysfs_xprt	*xprt_sysfs;
>  	bool			main; /*mark if this is the 1st transport */

Seems fine to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

