Return-Path: <linux-fsdevel+bounces-149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF47C625F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 03:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724E51C20C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 01:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5E7EF;
	Thu, 12 Oct 2023 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lL+Z9oNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B66657;
	Thu, 12 Oct 2023 01:45:20 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A444E98;
	Wed, 11 Oct 2023 18:45:18 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231012014516epoutp04c3ac5cb2248aba0ef58fba6a05c5bd6f~NONO2GwH41763017630epoutp04Z;
	Thu, 12 Oct 2023 01:45:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231012014516epoutp04c3ac5cb2248aba0ef58fba6a05c5bd6f~NONO2GwH41763017630epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697075116;
	bh=mSSwdhO6iAHAOEF3p3uIGoMW4JID2KH+xXt+a7q18zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lL+Z9oNPd3WBt7ClIJee/bGX23lhFYlt+FyXVO/vPzmWiiUFrjz66glJb3VqrIYaD
	 hwKEnKLSmJb2/ORik1HXbq4t/FyKZhgx1/tbFIMIAx/ywuPW8WpARHtdbGRRMTLHDZ
	 ujXQkYKJ+vLPDh/wAP8Wk7HF6UfsRPw4WBtq+4js=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231012014516epcas2p4820e15420eb03a034943d280d0743666~NONOeTaKW1250412504epcas2p4E;
	Thu, 12 Oct 2023 01:45:16 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4S5XWv33qJz4x9Pr; Thu, 12 Oct
	2023 01:45:15 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.78.09649.BAF47256; Thu, 12 Oct 2023 10:45:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231012014514epcas2p3ca99a067f3044c5753309a08cd0b05c4~NONNRgGSp1736217362epcas2p3Z;
	Thu, 12 Oct 2023 01:45:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231012014514epsmtrp11618661b71bca5b44530bba8ce23a48e~NONNO1nP52141621416epsmtrp1C;
	Thu, 12 Oct 2023 01:45:14 +0000 (GMT)
X-AuditID: b6c32a46-1c3eaa80000025b1-42-65274fab2c6b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.0F.08742.AAF47256; Thu, 12 Oct 2023 10:45:14 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231012014514epsmtip1831e5824c182001ced8785e96c927f36~NONM7MXAT1906819068epsmtip1g;
	Thu, 12 Oct 2023 01:45:14 +0000 (GMT)
Date: Thu, 12 Oct 2023 10:35:05 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 17/37] arm64: mte: Disable dynamic tag storage
 management if HW KASAN is enabled
Message-ID: <20231012013505.GB2426387@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230823131350.114942-18-alexandru.elisei@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeTBdVxzHe+69777H9MW1JDmRSapPs9BanvWQEJOit1uqk6SdyXTCG+54
	guflLdJEJ0UREbUbJYiloRFCbEksr5YXW1UbirG2KBPEUmlIKOnjaif/fX7f8/2e3zm/M4eH
	6/3CNeT5SRSMTCIKEJDaRHWziZ3Z7U8OMZZ/9+qgzNJiEqXd6iGRqs0brSe1cFH3RK9Gmg4j
	0EJBLEDPSldxNJlQhaPGnHkCTS7FEeh3VSGGRuJTCXRvag5DM5XNBIqueUag8ok+DqqrbydQ
	T00miUaLX3KQuvRnAj3IbOeg5PkpgPILD6LuhhwMpb54QqL44X4StX7bgCFV9B+YxnsPQ2Hq
	BRKlDw0BFK1exlH9xgsCVT1c4aKIYVs0cLOM63KALs4uBvTaahKgI1SDXDqnXElHqOc4dMUP
	pnR50VWSLl9K4tLDfXUk3fbdGkHnhqbidMX3X9OPK9IBvaDqJemKn0Lop+X7Pagz/kfFjMiH
	kRkxEu8gHz+Jr5Pgw5Oe73ra2lkKzYQOyF5gJBEFMk4C1488zNz9AjTDFBgFiwKUGslDJJcL
	LJyPyoKUCsZIHCRXOAkYqU+A1F5qLhcFypUSX3MJo3AUWlpa2WqMXv7ilIxeTKqivpy+cTwU
	VPBjgBYPUjaw7PojbgzQ5ulR9wHsyr2CscUSgCMlidvFMoBj9QlkDOBtRYYGHFm9HsCohLZt
	0ySA4U9XOJv7EtQBOHe3mNxkkjoE2yoLwCYbUBZwvGoGbAZwqoOEI9c7sc0FfeoczI0f2zLx
	KXNYVn8XY1kXtqf/SWyyFuUCo0ZvbnWDVKo2rK1eBOyRXOHq8jH2QvpwprWSy7IhnI6P2mZ/
	OPJXAsmyAt7pDN3WrWHG1JWtvjglhr9OjW9vaQzVgwQr74DRzetcVubD6Cg9NmkMfyzIJlje
	A8dLrnBYCw07Vz5mR9KmmdvsGpYA9me8cpmMV5qx/A7MqV0iMzRxnNoLCzd4LJrA0hqLHMAp
	ArsYqTzQl5FbSa3+f17voMBysPWzTN3vg5S5RfMmgPFAE4A8XGDAH/d7i9Hj+4guXmJkQZ4y
	ZQAjbwK2mqdJxA13egdpvqZE4Sm0cbC0sbMT2lvZWtoLdvNHI7N89ChfkYLxZxgpI/svh/G0
	DEOxq5FGR6y/Mnw473YmrGeuZfW9UwOL/bbG/5zsH53MG7vVJHZFs+cKq17qmLXmRQccPu/T
	Mb3v2FKk/nN8IS3rdnNdBflm8jW5uIV6NOTWqB4pCQ3mhaZXZc8njtYKqXBl3I1vdh6kmd2w
	2nP9cs1ojdfnyfgdXXXI6dff+O1wHD/rU8n4ieSUwRwP7Emavcfsjj6XDX/nyvOxWUO0g1G+
	e5GN6bX3g5X5tVZ7HY/I7DpCpmoiL5xuUD8w4cTqhhuUYF5dzt6fdbs1nhhjXrOemN/3BUel
	Y4hdsHhunKg8e3FPwSXM5u0qeojK0/tgsvlxdXXXogt+1gnXh5fzrU+t7FLWCwi5WCQ0xWVy
	0b9Bj5x04gQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxiG855zenpaqZ4VXN9KxpKiEpqtiMzszbZs/PDHu2SOhWSQACqV
	nvBZ7FpwfiwR0iIMQQgMhbZxMOVjXSdSyscQOgZV2lijwVhFGGxAGeqQQcMWZHSjkGX+u3Pf
	15U8Px6GFF/k7WKy8ws4bb4yT0YLqe5hWcSbloQobp9pOBqZ2600uvTtfRo5XBloveYWH43O
	PNionhRTaLGlAqCV9hck8lV3keinxucU8i1foNCUo5VAP1fVUahnboFAT+3DFCrrW6GQbcbL
	Q/0Dbgrd7zPTaNL6Dw852+9Q6Aezm4dqn88BdKV1LxodbCRQ3ervNKqaeEijkcpBAjnKfiE2
	2B4CFTsXadQwPg5QmfNPEg0EVinUdfMvPjJMHEBjzdf58Xuw9bIV4LUXNQAbHI/5uNFWiA3O
	BR7ubJNjm+VLGtuWa/h4wttPY1f9GoWbiupI3Hn1LJ7vbAB40fGAxp23z2C/LeITNkX4norL
	yz7BaWPeTxdmTX2jJzQB0UnrlB8UgYpt5YBhIPsWHB97pxwIGTF7A0BLST0oB4KNXgqNfjex
	lUPhlMHJ24JmALxrD5DBgWL3wIUOKx3MNBsFXfaWTTmMjYHTXU9BUCBZDw0vfGfkBYdQNgc2
	Vf26CYlYBbw+0EEErxCzBVBfK9qqX4HuhlkqmElWDh8FnmwiJBsOWwNMsBaw8fDcZDNRDVjj
	S4bxJcP4v9EISAuQchqdOlOti9XE5nOfK3RKta4wP1ORcVxtA5uvI4/uBT2WPxRDgGDAEIAM
	KQsTTWfv5sQilfLUaU57/Ki2MI/TDYFwhpJJRJL5SpWYzVQWcLkcp+G0/60EI9hVRMSFnXkj
	cvCerfZgmSFxzd53Iydt6d2UuI/2dvSmSrtDtk/7S1xelSMQ+Oqknb+UViKMbOanpNbw5o79
	XembK8SPdl6r6Ikylcadkh1jCi67Rkeks55cRfiY6aCkzRvx0H3r427VgSZJbtehBP2aMKX/
	cG/S+dX4bfvPSfZHmNXL5ntHDt3JOJ2V5kl+tXof/fVOI/3Mr5+tf2xIf126FH1TEBKT4LCk
	wuJk/Wt3L04mj6234IyFxMVr9fGmUO9Rwacn5GmXPDk+ZkWnbJvf0Xk4cfKIZbtL4ytNoj7j
	cW+nG5IyvxgK2WG+vV561bEya4r11H448uMHv0V+bzp7Hj+TUbosZayc1OqU/wIpMteEqQMA
	AA==
X-CMS-MailID: 20231012014514epcas2p3ca99a067f3044c5753309a08cd0b05c4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----E9vxk1eHFJMo0Hi_Q_rTTD2vXp5VKj0nvvVRz8vbSgBSYVSL=_d92b1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012014514epcas2p3ca99a067f3044c5753309a08cd0b05c4
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
	<20230823131350.114942-18-alexandru.elisei@arm.com>
	<CGME20231012014514epcas2p3ca99a067f3044c5753309a08cd0b05c4@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

------E9vxk1eHFJMo0Hi_Q_rTTD2vXp5VKj0nvvVRz8vbSgBSYVSL=_d92b1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Aug 23, 2023 at 02:13:30PM +0100, Alexandru Elisei wrote:
> Reserving the tag storage associated with a tagged page requires the
> ability to migrate existing data if the tag storage is in use for data.
> 
> The kernel allocates pages, which are now tagged because of HW KASAN, in
> non-preemptible contexts, which can make reserving the associate tag
> storage impossible.
> 
> Don't expose the tag storage pages to the memory allocator if HW KASAN is
> enabled.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/kernel/mte_tag_storage.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> index 4a6bfdf88458..f45128d0244e 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -314,6 +314,18 @@ static int __init mte_tag_storage_activate_regions(void)
>  		return 0;
>  	}
>  
> +	/*
> +	 * The kernel allocates memory in non-preemptible contexts, which makes
> +	 * migration impossible when reserving the associated tag storage.
> +	 *
> +	 * The check is safe to make because KASAN HW tags are enabled before
> +	 * the rest of the init functions are called, in smp_prepare_boot_cpu().
> +	 */
> +	if (kasan_hw_tags_enabled()) {
> +		pr_info("KASAN HW tags enabled, disabling tag storage");
> +		return 0;
> +	}
> +

Hi.

Is there no plan to enable HW KASAN in the current design ? 
I wonder if dynamic MTE is only used for user ? 

Thanks,
Hyesoo Yu.


>  	for (i = 0; i < num_tag_regions; i++) {
>  		tag_range = &tag_regions[i].tag_range;
>  		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages) {
> -- 
> 2.41.0
> 
> 

------E9vxk1eHFJMo0Hi_Q_rTTD2vXp5VKj0nvvVRz8vbSgBSYVSL=_d92b1_
Content-Type: text/plain; charset="utf-8"


------E9vxk1eHFJMo0Hi_Q_rTTD2vXp5VKj0nvvVRz8vbSgBSYVSL=_d92b1_--

