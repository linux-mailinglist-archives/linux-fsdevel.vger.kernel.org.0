Return-Path: <linux-fsdevel+bounces-30154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9985B9870BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E799F1F21B3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7367B1AC452;
	Thu, 26 Sep 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="dGQFQZy8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B031ABECE;
	Thu, 26 Sep 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344379; cv=none; b=mcs8xL+ZblB+Eadx+Y3OW7BdbhlLsuqmRu5Gg/6MnoX2COD4QZ6h7wRKY0mSei9NiOByAutHJRrFTIGHPZo4laI0azIujRgNBh637OuybbmmBwJgD1UoeaEo5U9dYM8R+cZuOEyqhEmxqchBneY92Kzudl39ZHvmTZ3lLLp4v+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344379; c=relaxed/simple;
	bh=EmSsw/e31zL1tZYVXDYfeSoSUGd/RqgBnotnQqRhayY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW+GsYq05BYaSYbTJYJ4AotzfbrgJYOMITJ7yxHHvgCJbVlf9njH1aMhDW+72MecLMy2iGnjali4eOVz0KQS4hPEwIH0xVAnTr++52krOYuRO1jhSMe4yyLOBjIVi8EH7yksQMK592KqvEqgsQ+63IwjVfO5iZgAzxOa+sHrW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=dGQFQZy8; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4212; q=dns/txt; s=iport;
  t=1727344378; x=1728553978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZGKzS95sQGD97oxxt1DK7jeDzl9OHurCeUjrLdIcwjk=;
  b=dGQFQZy8jADpHWwfaxhCywnwZWGzK2wtILsRhr5OjDS/GaiU5HY4VmV8
   FY3H9yn4o+ZKaO80UXZqcLnXWoUYFlOxi0yNdKJTBkc4+EHQp2spA4sdW
   wk/Oz/If/2v8QUpaoaagiuWyb2diL1RYtXjwAoEjW6/zs7Dw+rAaAsigl
   k=;
X-CSE-ConnectionGUID: 5MVxrBN4TpqSeUy+2OSGwA==
X-CSE-MsgGUID: d05BKP/fRky454U9mGi/DQ==
X-IPAS-Result: =?us-ascii?q?A0AJAADiLfVmmJldJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYNAWUNIhFWIHYcwgiIDnhWBfg8BAQENAQE5CwQBAYFyAYJORgKKB?=
 =?us-ascii?q?QImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQUBAQUBAQECAQcFFAEBAQEBAQEBN?=
 =?us-ascii?q?wUOO4V1DYZbAQEBAQIBIw8BRhALDgoCAiYCAlYGgxQBgkEjAxEGrxYaN3qBM?=
 =?us-ascii?q?oEB3jKBbIEaLgGISgGFZhuEXCcbgUlEhD8+gig5AQKFOoJpBIoIP4FMgiRSg?=
 =?us-ascii?q?nEPgyaDekQMMgOCTWYWJU1VhxcncIQXjGdSe3ghAhEBVRMXCwkFiTgKgxwpg?=
 =?us-ascii?q?UUmgQqDC4Ezg3KBZwlhiEmBDYE+gVkBgzdKg0+BeQU4Cj+CUWtOOQINAjeCK?=
 =?us-ascii?q?IEOglqFAFMdQAMLbT01FBusO4FbSIJBBz0kAlUCBXaBTS+WBo5ioQOEIowWl?=
 =?us-ascii?q?SZNEwODb40BhkSSe5g4Po17mngCBAYFAheBZzqBWzMaCBsVgyIJSRkPileDV?=
 =?us-ascii?q?g0Jg1iFFLlPQzICATgCBwEKAQEDCY1SAQE?=
IronPort-Data: A9a23:5n0Iaq0F2VaOx42Z0/bD5d12kn2cJEfYwER7XKvMYLTBsI5bpzAAz
 GJKXmHVOP6DamTxe4sna4ripk9XucfRnIBrTVY93Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yEzmG4E/0YtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 bsen+WFYAX5g28ubDpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGUWQILZcy3LpLGXh1+
 MEJa2oqVT+crrfjqF67YrEEasULNsLnOsYUvWttiGufBvc9SpeFSKLPjTNa9G5v3YYVQrCPP
 IxANGEHgBfoO3WjPn8eDZM1geOhnVH0ciZTrxSeoq9fD237llEriem8aIeFEjCMbckNw2y7n
 iXIxWfoXkxGCY2a5jvC3kv504cjmgugBdpNT+fnnhJwu3WXx2oOGFgbT1y1utG9i1WiQJRYO
 Ugd8DFoqrI9nGSvT9/gT1i2u3KJoBMYc8RfHvd86wyXzKfQpQGDCQAsQTdbefQpvdUnSiEtk
 FmEg7vBGz11t5WHRHSc6PGQrDWvKW4SN2BEeCxsZRcC+cfqpI0ophbOSMtzVaCyk9v5EC3xx
 DbMqzIx750XjMgWx+C48ErBjjaEuJfEVEg26x/RU2bj6Rl2DKaqfYGn6ljz6fdGMZaXSUSHs
 HEYms+YqucUAvmljjGWXKADG6vs4/eDLS30n1FiBd8i+i6r9nrleppfiBl0KUFvNYAAfiTyY
 Un7oRlW+JhVen6nBYd3eIO4DcspxK/IEdXjS+CSZ95PaJF7fUmM+yQGWKKL93rmnE5pmqYlN
 NLBN82tFn0dT69gyVJaWtvxz5d24x4u30n1Gazj1i+q7KvdPlmuZqgsZQ7mgv8C0IuIpwDc8
 tB6PsSMyglCXOCWXsUx2dBPRbztBSZnba0au/Bqmvi/zh2K8VzN5tfLyr8nPodihakQzKHD/
 2q2XQlTz1+XaZz7xeeiNCwLhFDHBMoXQZcH0coEZgjAN58LOt3H0UvnX8FrFYTLDcQ6pRKOc
 9ELet+bHtNEQSnd9jIWYPHV9dM4K0771FvUb3L1MVDTmqKMoSSUpLcImSOypUEz4taf75dWT
 0CIj1mCGMFSHWyO8u6NMq31kztdQkTxaMopAhOXeYMMEKkd2INrMCf2xuQmON0BLA6Lxz2Rk
 W6r7eQw+4HwT3sO2ICR38is9t7xe8MnRxYyNzeAt96ea3KFlldPNKcdCo5kixiHCjOtkEhjD
 M0Ip8zB3AovxwoU7NUsSOc3nMrTJbLH/tdn8+itJ12TB3zDN1+qCiPuMRVn3kGV+oJkhA==
IronPort-HdrOrdr: A9a23:SiGP06w4dc0tuBott7QZKrPwCb1zdoMgy1knxilNoNJuHfBws/
 re+cjzsiWE7Ar5OUtQ++xoV5PrfZqxz/NICMwqTNCftWrdyQiVxeNZjLcKqgeIc0bDH6xmtZ
 uIGJIRNDSfNzRHpPe/yBWkEtom3dmM+L2liKPj1Xt3JDsaDZ2JK2xCe36m+oocfng+OaYE
X-Talos-CUID: 9a23:VYFqjG9RK7w/J1N5/aaVvxMxJNA/WFuB8G/JGEKFGCUzb4a6VnbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3APNWo/A9m1agCWxyO7MHQ6LeQf8swvo6NMAcDq5Y?=
 =?us-ascii?q?X55TYCH11FDbaoA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,260,1719878400"; 
   d="scan'208";a="252199058"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:51:49 +0000
Received: from localhost ([10.239.201.197])
	(authenticated bits=0)
	by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48Q9pjEl021034
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Sep 2024 09:51:48 GMT
Date: Thu, 26 Sep 2024 12:51:40 +0300
From: Ariel Miculas <amiculas@cisco.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
References: <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.201.197, [10.239.201.197]
X-Outbound-Node: rcdn-core-2.cisco.com

On 24/09/26 04:25, Gao Xiang wrote:
> 
> 
> On 2024/9/26 16:10, Ariel Miculas wrote:
> > On 24/09/26 09:04, Gao Xiang wrote:
> > > 
> 
> 
> ...
> 
> > 
> > And here [4] you can see the space savings achieved by PuzzleFS. In
> > short, if you take 10 versions of Ubuntu Jammy from dockerhub, they take
> > up 282 MB. Convert them to PuzzleFS and they only take up 130 MB (this
> > is before applying any compression, the space savings are only due to
> > the chunking algorithm). If we enable compression (PuzzleFS uses Zstd
> > seekable compression), which is a fairer comparison (considering that
> > the OCI image uses gzip compression), then we get down to 53 MB for
> > storing all 10 Ubuntu Jammy versions using PuzzleFS.
> > 
> > Here's a summary:
> > # Steps
> > 
> > * I’ve downloaded 10 versions of Jammy from hub.docker.com
> > * These images only have one layer which is in tar.gz format
> > * I’ve built 10 equivalent puzzlefs images
> > * Compute the tarball_total_size by summing the sizes of every Jammy
> >    tarball (uncompressed) => 766 MB (use this as baseline)
> > * Sum the sizes of every oci/puzzlefs image => total_size
> > * Compute the total size as if all the versions were stored in a single
> >    oci/puzzlefs repository => total_unified_size
> > * Saved space = tarball_total_size - total_unified_size
> > 
> > # Results
> > (See [5] if you prefer the video format)
> > 
> > | Type | Total size (MB) | Average layer size (MB) | Unified size (MB) | Saved (MB) / 766 MB |
> > | --- | --- | --- | --- | --- |
> > | Oci (uncompressed) | 766 | 77 | 766 | 0 (0%) |
> > | PuzzleFS uncompressed | 748 | 74 | 130 | 635 (83%) |
> > | Oci (compressed) | 282 | 28 | 282 | 484 (63%) |
> > | PuzzleFS (compressed) | 298 | 30 | 53 | 713 (93%) |
> > 
> > Here's the script I used to download the Ubuntu Jammy versions and
> > generate the PuzzleFS images [6] to get an idea about how I got to these
> > results.
> > 
> > Can we achieve these results with the current erofs features?  I'm
> > referring specifically to this comment: "EROFS already supports
> > variable-sized chunks + CDC" [7].
> 
> Please see
> https://erofs.docs.kernel.org/en/latest/comparsion/dedupe.html

Great, I see you've used the same example as I did. Though I must admit
I'm a little surprised there's no mention of PuzzleFS in your document.

> 
> 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
> Compressed OCI (tar.gz)	282.5	28.3	63%
> Uncompressed OCI (tar)	766.1	76.6	0%
> Uncomprssed EROFS	109.5	11.0	86%
> EROFS (DEFLATE,9,32k)	46.4	4.6	94%
> EROFS (LZ4HC,12,64k)	54.2	5.4	93%
> 
> I don't know which compression algorithm are you using (maybe Zstd?),
> but from the result is
>   EROFS (LZ4HC,12,64k)  54.2
>   PuzzleFS compressed   53?
>   EROFS (DEFLATE,9,32k) 46.4
> 
> I could reran with EROFS + Zstd, but it should be smaller. This feature
> has been supported since Linux 6.1, thanks.

The average layer size is very impressive for EROFS, great work.
However, if we multiply the average layer size by 10, we get the total
size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
the average layer size is 30 MIB (for the compressed case), the unified
size is only 53 MiB. So this tells me there's blob sharing between the
different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
with EROFS (what I'm talking about is deduplication across the multiple
versions of Ubuntu Jammy and not within one single version).

Of course, with only 10 images, the space savings don't seem that
impressive for PuzzleFS compared to EROFS, but imagine we are storing
hundreds/thousands of Ubuntu versions. Then we're also building OCI
images on top of these versions. So if the user already has all the
blobs for an Ubuntu version, then we only need to ship the chunks that
have changed / have been added as a result of the specific application
that we've built on top of an existing Ubuntu version.

One more thing: the "Unified size" column is the key for understanding
the space savings offered by PuzzleFS and I see that you've left this
column out of your table.

Regards,
Ariel

> 
> Thanks,
> Gao Xiang

