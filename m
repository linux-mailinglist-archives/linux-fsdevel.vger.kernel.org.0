Return-Path: <linux-fsdevel+bounces-30165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F075C9873D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 14:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A391C22A07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ACE1C6A5;
	Thu, 26 Sep 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="TgJWjjzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282046B8;
	Thu, 26 Sep 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355046; cv=none; b=tgjsxiU38uwjyr6IltrvRUOUEVuN8WXJgtttjLaEgP12Ke5UTgjold96nYh+SA8qb+fEc1jlbzivYa6njEtKisExNFJthO06pruPn5foAc/816/Gp/uSybRtEqp+K4Kd0tPdaK636r1/tNTJq8DYsR+NoYHrNmDEg5LwNVqsXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355046; c=relaxed/simple;
	bh=HpEH1I1Vcnd91MrjF7/NAUvh7yNPBBOXQfe3Vtenfmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2X/yqVSm9Y6m1+7GELba3NluowYgwkdOdqyYvlqXwaH0y0Gx26GIbps7DdhYlABS+kjrj0AeB4UZnVYsFq96UrB7qzXSgOu2UZCGq5XP+FSsquQgCHMOXqyciRC0XE2GV8oTI30FSTOP2GmcT5H3VmFX2drsZD8C85AUQAZVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=TgJWjjzb; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4726; q=dns/txt; s=iport;
  t=1727355043; x=1728564643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=13XC0SDx7lZbkZwxtT4I64b73mMeM0qQgCELOwdYjSo=;
  b=TgJWjjzbUrvEbtz8/8veAkW1LHiz1gzY5G6imdywtBI2BKEFMsZCFwQ7
   /F/Rg918VtnLQbPoD1dAGV3Cq7Br9Roct5gwSbHdQag71wsiuG2fRzG6P
   qLTwHNZiw/gx49DCBJAQ2TCNxHM4DpjnSrii5/VaGqIIMqmv7iJhdfSUG
   Y=;
X-CSE-ConnectionGUID: jd8hYSBIQWapzH8zNMkltg==
X-CSE-MsgGUID: 7LAFSQ8CTeiChYQd1EcnLg==
X-IPAS-Result: =?us-ascii?q?A0AJAABWV/VmmJNdJa1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYNAWUNICYxphzCCIgOeFYF+DwEBAQ0BATsJBAEBhQcCi?=
 =?us-ascii?q?gUCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEFAQEFAQEBAgEHBRQBAQEBAQEBA?=
 =?us-ascii?q?TcFSYV1DYZbAQEBAQIBOjoFEAsOCi5WBoMUAYJBIwMRBq9+eIE0gQGDbEHaB?=
 =?us-ascii?q?YFmBoFIAYhKAYVmG4RcJxuBSUSEPz6CYQICgTaGbASOfHCEN4UGgQIDgRCBP?=
 =?us-ascii?q?WYWJU1ViC6QflJ7eCECEQFVExcLCQWJOAqDHCmBRSaBCoMLgTODcoFnCWGIS?=
 =?us-ascii?q?YENgT6BWQGDN0qDT4F5BTgKP4JRa045Ag0CN4IogQ6CWoUAUx1AAwttPTUUG?=
 =?us-ascii?q?6w7gVtIgkFoLQEHJAV2CgyBLDqWBo5in0WBPoQijBaVJk0TA4NvjQGGRJJ7m?=
 =?us-ascii?q?HaNe5VWhSICBAYFAheBZzqBWzMaCBsVgyNRGQ+OLQ0Jg1i+WUMyOwIHCwEBA?=
 =?us-ascii?q?wmLVoF8AQE?=
IronPort-Data: A9a23:6ebSZaDSyrwhbhVW/yHkw5YqxClBgxIJ4kV8jS/XYbTApD4hhTdSx
 2EXUDuEP6mOZmvyeo8iboSwp0wAv5LSnd5jOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4SGcYZuCCeF9n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWmthh
 fuo+5eDYA7/hWYoWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEwfk+DHANF6whxe9vE0Ee5
 9o9KzQRYUXW7w626OrTpuhEnM8vKozgO5kS/yg5izrYFv0hB5vERs0m5/cBg2x23Z8ITK2YP
 pZGAdZsREyojxlnM1IWA486lfyAjXjkeDoeo1WQzUYyyzKOllYuiuiyYbI5fPTVYex7pX/Ij
 V7L/k/5MygWbfGUzx6KpyfEaujnxn6jB9lIS9VU7MVChFyV23xWBQcRW0CTpfiillX4XMBbI
 kYPvC00osAa8E2tU8m4UQa0rWCJujYCVNdKVe438geAzuzT+QnxLmcNVC9pZ9U8pcArQnos2
 0Pht83oHztHorCTSGzb8raSsCP0PjIaa3IBDQcYShEb6t3vu6k3jxTSXpNtF7OzgtTpGDb2h
 TeQo0AWg7QVkN5O1Kih+13Dqyyjq4KPTQMv4AjTGGW/4WtRa5SoaI+owVza6+tQIoGESFWIo
 HkDnY6Z9u9mJYuQjzDITuIXWbWo4euVGCPTjEQpHJQ78TmpvXm5cuh46jx4IkAvNsEfYj7vS
 FfJvh9W4tlWMROCbbR2aoS+CM0t5azhE8n1EPnQb9BHaJE3fwiClByCfmaK1Gzr1UMri6x6Y
 M7dese3BnFcAqNipNarewsD+b0nliAP/knyfK/y1waHgai4QX2RVbhQZTNicdsFxK+DpQzU9
 fNWOM2L1whTXYXCjs//r9J7wbcicyRTOHzml/G7YNJvNeaPJY3MI+XazbVkcIt/kuEMz6HD/
 2q2XQlTz1+XaZz7xeeiNC4LhFDHBMoXQZcH0coEZgrAN58LOtrH0UvnX8FrFYTLDcQ6pRKOc
 9ELet+bHtNEQSnd9jIWYPHV9dM4K0771FvUb3L1MVDTmqKMoSSUpLcImSOypUEz4taf75dWT
 0CIj1mCGMFSHWyO8u6NMq31kztdQkTxaMopAhOXeYMMEKkd2INrMCf2xuQmON0BLA6Lxz2Rk
 W6r7eQw+4HwT3sO2ICR38is9t7xe8MnRxoyNzeAt96ea3KFlldPNKcdCo5kixiHCjOtkEhjD
 M0Ip8zB3AovwQ8R4tojQu0xpU/8jvO2z4JnIs1fNC2jRzyW5nlIexFqAeEnWnVx+4Jk
IronPort-HdrOrdr: A9a23:bmANwaBiEHGtGG3lHemd55DYdb4zR+YMi2TDtnoddfUxSKfzqy
 nApoV/6faKskd0ZJhCo7y90cu7MBHhHPdOiOEs1L6ZLW7bkWGjRbsD0WNFrgePJwTk+vdZxe
 N8dcFFeb7NJEJnhsX36hTQKbkd6cSAmZrIudvj
X-Talos-CUID: =?us-ascii?q?9a23=3AxAWj82sxdMMXsCVehTNpdpMM6Isnfi3d/Uz6Ana?=
 =?us-ascii?q?HAH57aO2Hb3qT/L9rxp8=3D?=
X-Talos-MUID: 9a23:4E292wqt3VbOusIoWYwez25GHelT2vSFNE0MupU3gsXdGCd2HzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,155,1725321600"; 
   d="scan'208";a="252272879"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 12:50:40 +0000
Received: from localhost ([10.239.198.46])
	(authenticated bits=0)
	by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48QCobmw029017
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Sep 2024 12:50:39 GMT
Date: Thu, 26 Sep 2024 15:50:36 +0300
From: Ariel Miculas <amiculas@cisco.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240926124959.n7i33p4fonp2op27@amiculas-l-PF3FCGJH>
References: <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
 <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
 <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
 <ec17a30e-c63a-4615-8784-69aef2bb2bae@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec17a30e-c63a-4615-8784-69aef2bb2bae@linux.alibaba.com>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.198.46, [10.239.198.46]
X-Outbound-Node: rcdn-core-11.cisco.com

On 24/09/26 07:23, Gao Xiang wrote:
> 
> 
> On 2024/9/26 19:01, Ariel Miculas via Linux-erofs wrote:
> > On 24/09/26 06:46, Gao Xiang wrote:
> 
> ...
> 
> > > 
> > > > 
> > > > > 
> > > > > 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
> > > > > Compressed OCI (tar.gz)	282.5	28.3	63%
> > > > > Uncompressed OCI (tar)	766.1	76.6	0%
> > > > > Uncomprssed EROFS	109.5	11.0	86%
> > > > > EROFS (DEFLATE,9,32k)	46.4	4.6	94%
> > > > > EROFS (LZ4HC,12,64k)	54.2	5.4	93%
> > > > > 
> > > > > I don't know which compression algorithm are you using (maybe Zstd?),
> > > > > but from the result is
> > > > >     EROFS (LZ4HC,12,64k)  54.2
> > > > >     PuzzleFS compressed   53?
> > > > >     EROFS (DEFLATE,9,32k) 46.4
> > > > > 
> > > > > I could reran with EROFS + Zstd, but it should be smaller. This feature
> > > > > has been supported since Linux 6.1, thanks.
> > > > 
> > > > The average layer size is very impressive for EROFS, great work.
> > > > However, if we multiply the average layer size by 10, we get the total
> > > > size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
> > > > the average layer size is 30 MIB (for the compressed case), the unified
> > > > size is only 53 MiB. So this tells me there's blob sharing between the
> > > > different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
> > > > with EROFS (what I'm talking about is deduplication across the multiple
> > > > versions of Ubuntu Jammy and not within one single version).
> > > 
> > > Don't make me wrong, I don't think you got the point.
> > > 
> > > First, what you asked was `I'm referring specifically to this
> > > comment: "EROFS already supports variable-sized chunks + CDC"`,
> > > so I clearly answered with the result of compressed data global
> > > deduplication with CDC.
> > > 
> > > Here both EROFS and Squashfs compresses 10 Ubuntu images into
> > > one image for fair comparsion to show the benefit of CDC, so
> > 
> > It might be a fair comparison, but that's not how container images are
> > distributed. You're trying to argue that I should just use EROFS and I'm
> 
> First, OCI layer is just distributed like what I said.
> 
> For example, I could introduce some common blobs to keep
> chunks as chunk dictionary.   And then the each image
> will be just some index, and all data will be
> deduplicated.  That is also what Nydus works.

I don't really follow what Nydus does. Here [1] it says they're using
fixed size chunks of 1 MB. Where is the CDC step exactly?

[1] https://github.com/dragonflyoss/nydus/blob/master/docs/nydus-design.md#2-rafs

> 
> > showing you that EROFS doesn't currently support the functionality
> > provided by PuzzleFS: the deduplication across multiple images.
> 
> No, EROFS supports external devices/blobs to keep a lot of
> chunks too (as dictionary to share data among images), but
> clearly it has the upper limit.
> 
> But PuzzleFS just treat each individual chunk as a seperate
> file, that will cause unavoidable "open arbitary number of
> files on reading, even in page fault context".
> 
> > 
> > > I believe they basically equal to your `Unified size`s, so
> > > the result is
> > > 
> > > 			Your unified size
> > > 	EROFS (LZ4HC,12,64k)  54.2
> > > 	PuzzleFS compressed   53?
> > > 	EROFS (DEFLATE,9,32k) 46.4
> > > 
> > > That is why I used your 53 unified size to show EROFS is much
> > > smaller than PuzzleFS.
> > > 
> > > The reason why EROFS and SquashFS doesn't have the `Total Size`s
> > > is just because we cannot store every individual chunk into some
> > > seperate file.
> > 
> > Well storing individual chunks into separate files is the entire point
> > of PuzzleFS.
> > 
> > > 
> > > Currently, I have seen no reason to open arbitary kernel files
> > > (maybe hundreds due to large folio feature at once) in the page
> > > fault context.  If I modified `mkfs.erofs` tool, I could give
> > > some similar numbers, but I don't want to waste time now due
> > > to `open arbitary kernel files in the page fault context`.
> > > 
> > > As I said, if PuzzleFS finally upstream some work to open kernel
> > > files in page fault context, I will definitely work out the same
> > > feature for EROFS soon, but currently I don't do that just
> > > because it's very controversal and no in-tree kernel filesystem
> > > does that.
> > 
> > The PuzzleFS kernel filesystem driver is still in an early POC stage, so
> > there's still a lot more work to be done.
> 
> I suggest that you could just ask FS/MM folks about this ("open
> kernel files when reading in the page fault") first.
> 
> If they say "no", I suggest please don't waste on this anymore.
> 
> Thanks,
> Gao Xiang

