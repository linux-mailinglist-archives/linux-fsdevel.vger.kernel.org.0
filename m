Return-Path: <linux-fsdevel+bounces-19855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A868CA603
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D731F21376
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 01:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E24FBE8;
	Tue, 21 May 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PYUxKZ3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2071.outbound.protection.outlook.com [40.107.15.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2868479E5;
	Tue, 21 May 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716256747; cv=fail; b=G8CQmtNbNs50EcZl+58/X2r6iVenbQUCN7bqsR6OmGvhzZPtwL+SoLGpoV+eOo68WCONYp5lh9EVK/nUypaYHvUzi7aUrPdI7f4RFTCINLozem6NExkWjnI7svG9WSyBKRPK3l0TXVlEy+5ONdp9MSDVyzpkfcrm90FFKsnor04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716256747; c=relaxed/simple;
	bh=nK3N/J2gT43MRLeXLLP69kP4odrUvAj4sU2Rd+P2AFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EnJqvA/rlPkW8YHyb5MdLxtFCXnWSfsy+RvPnzVSik4Yoh2+hs0HgzNgj6VrvT1xYPywoSVN5dUH0ntKwvVhwjuHEu/Pod4Gp0H5CvPa131KPn1Ihk4hV6Yq84jbShd7KVuJPWP+YqnB31hiBvjDTvnS0tOwMjkCSchpxQwkuNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PYUxKZ3d; arc=fail smtp.client-ip=40.107.15.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mmwhh7Uhm9Uf6XnLU4AX64fi49XTEDypZzUBZ9gV7D9Euqxi/nQT0ZkZ9owXcTwurH9XXl5b+0hojUpK9x2XwUq10pzVFsN1Lu17t3zr0axHuiUSHHQXasfdwqYiXZKAKQIFzo6wVl8IHrCrXbmYx6APuGDMlHfx+96STUAXNcq+IJhUOxpnAbgTJCjHcqtqHIsPEFSI18De0t9mEcShehCEPTvt5jiYCc3l7YxY1Q8+99n64EWXoa1wvEBvUoM/PfgokBEd8O/q5/KaDmNDeoqeBQrKSM+fZZwp9d8DMRl/ZlrDlVvmZYIIhvUOyxbz53lLQPKfZ9Bv/165q9wUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vxDz/i/t72dl762WkS39ebvv6nfwv32OfiJ9VAmlLU=;
 b=NQ/JpSZ3q19ZiJQqaPFZmojr28Mh1M9eZcB4Mb7OfzOR0Rpn456d0CLcBly71DJT9Yt7LNGT2STdRiszOhMoRktAStOo/ZcaygkMwS6L/6Dl9NM1ssir/3VmjHZV/VfnPRNKYHgdRTTNpTvOhPxkkYRW4TjFq+KUiM92nlDdbnfAwVVowJGbF3GoAJhlmGzL+JWqo+b10ezdF1ts1to8W5YEaVhnMpOZ3wANTnveQT3JuHsmJ4gnLrHmTApUOAJPmJvPSkW8UKeBH1buqrUStErm6kevqmWZ25TnvAZVjNJkuM1OT1muS7bH8cUA52bfRhzilnTNvHvgkDuUhbMEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vxDz/i/t72dl762WkS39ebvv6nfwv32OfiJ9VAmlLU=;
 b=PYUxKZ3dMx1bpFnbFpuw0CKqVqQDdknCEefly1vz6+k2ZPjO2AsQQws3WfBNKmEpaw5ebNkAETolJkF2+uZQaqGGnLb+3LaiDimdDBoFvY9FqwRH2BLyDTvtryyOjKcooLq0R9BExXD3RVyxl9C3B76KnWPYD3q6uWkwVjmIGLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU0PR04MB9660.eurprd04.prod.outlook.com (2603:10a6:10:31b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 01:59:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 01:59:03 +0000
Date: Tue, 21 May 2024 09:57:35 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, willy@infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jun.li@nxp.com
Subject: Re: [PATCH v3] iomap: avoid redundant fault_in_iov_iter_readable()
 judgement when use larger chunks
Message-ID: <20240521015735.bcgc7brwb334zybx@hippo>
References: <20240520105525.2176322-1-xu.yang_2@nxp.com>
 <20240520152917.GA485@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520152917.GA485@lst.de>
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU0PR04MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: c3df4318-646c-45d5-1c6d-08dc793996e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a0GxLtUg5Ork1qFLuIU83nl7U4lVijhYNGBQJmE+OlmUe71qywFl7+5QVwJ/?=
 =?us-ascii?Q?uOjMWfFgAcdZSqe9hy7QubIQ8jkmmuFGCNmERpI5Qpixr9vmlv28Kn5wO3TE?=
 =?us-ascii?Q?n9kz+0DZrEX9wnCmA3diuBphZnaANhQUg+mTRUhb4JzueUjE1PHk/NgOxHcZ?=
 =?us-ascii?Q?Cn5leXb0zvrKBVziJb/Sbanu82q4oa+M1s8V2zGFLdUyVMOA5Kos1xfrXsFp?=
 =?us-ascii?Q?mWFkTNYEv7EMsouoV6rW5BF/4OfCG46d8+5PVypie26oUPbJz9a5GdpZKvSV?=
 =?us-ascii?Q?BBxu8csMZeKf3Uo4on5YkuF3wpyaeUI4OuRm88pFMKy+452eZENe0BdCqOwd?=
 =?us-ascii?Q?97oqtclXxfCS+hCgfno18Dajo7GoGK5gzH5+wQmxCzFVAtPg/mTLeNZvcZdC?=
 =?us-ascii?Q?EDeiFptJ2Kllib2yJm85vWuIGJt0H9AVRd7VV2KMg4u3iu3VaCQ5WdI/py8v?=
 =?us-ascii?Q?3tGAvtbSlkrTkaKcihU8mJAHE/2ptEYKIaqPlVtbDV7pYpZkIo51AtN6D3lL?=
 =?us-ascii?Q?LLc+Xx3wI9t6uA6iTHeO29IeFUSZRcIbcBHfqZL6/OfnX4xCq2OQTYa3i4UF?=
 =?us-ascii?Q?i4sd1fxhlx7R+FhRA7ocEBIwJFrAu9OXORhd18iSkcz5ihVQtHyb65kyWLy/?=
 =?us-ascii?Q?hHq7DJeKpBB/V/p/W9DG4RvVnZY1KWGZXcyWrNx42piuty9iSvXf/nEMpAGB?=
 =?us-ascii?Q?B2ZorgMh0LWrfbLYJalLVrAAslbWVAneO4rGoyl21AkTC4ce//ybt1/uyfWw?=
 =?us-ascii?Q?f1cwH7jZgRR79NFL2eChCpdg3fb8eB/xy/7efM6jrZG/+RKWzF0VX9ToFmEA?=
 =?us-ascii?Q?C3rCDUoYXoOXeGb4tH24wYbE9CNSa2i/KMB7x5wVIIcboxZ4JT/dlJnlUdeL?=
 =?us-ascii?Q?K8ycWNPi2z8W5evEBp9IIpPDFaIzg3OtoBy5rOOESOFOLSLf7WX0lvtGXl3U?=
 =?us-ascii?Q?9luxFBZ59eqwRj0uF6xL8eEeTAIHgDHDt/weZXImt+XvVUB6YfPjJYec8nkM?=
 =?us-ascii?Q?VnhfX/eV0BfBh2FI897V23FBKcxxTYgDm7kw0GEECZjYfmDSl+ZHgv7O3FRp?=
 =?us-ascii?Q?Wa0IEFBF7loyEFhuWQRQyOcbsCd5Ke6XxwJjzK/i0pdXXoLYoiJ1seLeY7aW?=
 =?us-ascii?Q?AEeEHHfA8198u1vW+XYi2lUG4yWzwVUHFu6bVHdqyh6OCT+42dItU3f7tq3J?=
 =?us-ascii?Q?pt3pjTtge2jdcACaRhImRWq7Zr/qsaTvxtF5q2SUtU/aprcOPOUHTOdjKCHO?=
 =?us-ascii?Q?YJ72rXUJEAsrpzBgR9v+xhQ8j5T+eM38GV63B5JREJUJM8clRSQsunRovItT?=
 =?us-ascii?Q?YnodkiSFRUEHSYJ447BvGeXS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4PGM32KsG9Gr+JxRFPAkNsEwULfU6NrW8O/WmHAaapg5dpT8PhQa5QSB85/Y?=
 =?us-ascii?Q?smak0amI6uXMUq8VKICVJ4MWVNIyTebd2/28L1XsdHD3FMONCEvbnmaIeaFX?=
 =?us-ascii?Q?vhmaopGbzrh11Nf/xAP1Cf2YfNkFJ5T0LA4opEfKtpXjycZeqVT01yQ3dc3G?=
 =?us-ascii?Q?XBs+iEm5CIw9wBG4YwHekT5Kgttgd+xVRbr0tVm+hiZ3McWsSc+VI1088DNw?=
 =?us-ascii?Q?3R7ngFlHTZrM0m75PbdvfoTJJs0Pp0Zpca72Ve0xZNHsd4FJFT+FWQElyS5h?=
 =?us-ascii?Q?BO+4DHrQndbLCdaFv1CgKBaXswqV1ZSZRAT3F7l0zGe0tEecMQGUWy1UyzaQ?=
 =?us-ascii?Q?89Nf0hTW/ajA/Z/9YAB4fQYxiKw0gOhActw7gOIbCOZg+Jh8E6MQEykXjXwI?=
 =?us-ascii?Q?NjkHv8uwWP/PcVeOC33mtZS+dLSkLMznJEwGlZWf25wut5Y/KQZVL3Guv14l?=
 =?us-ascii?Q?/f6z8nl0kfqwkNo9VzCHkprzYJNJZkD7L0FSyJJ3fPsI8BqdSBdgLxxqyxPi?=
 =?us-ascii?Q?TCOH/7u6C8/bQ7AjQZlC0wBTnwj1erytcLl8LGda55/vbN8FO/mSd1lQXjB8?=
 =?us-ascii?Q?aVYtX1SMJtjg7kdoo0H4pvYtcRwmPieadx196EOkIaI9PiUz+xIxfbLZHn93?=
 =?us-ascii?Q?LF1F9B/4TXvh4yym85hm+I62Xe765OlBqkeV7/6Qi+vM/LKyFb4Lvdx1Nvuw?=
 =?us-ascii?Q?mDQZ6VsikwW0OO3+atyPgTLa3t6gB8PYrHgD4o8g4/VFWAf+41nCRb8Q6yND?=
 =?us-ascii?Q?CGyN7gPTK2UZzkx5fTOJc/FQdeiCEmIp7v8gFf7WgwoS4U6XEhsoPUaqYcyv?=
 =?us-ascii?Q?bJXnBPdbGB5Gz+KDv8VdcPPufb8u9wHJ1RD2bdjC/ynfFJLQKPT8aJiy3oLL?=
 =?us-ascii?Q?9/SBAbIMt5h0bkHmTWyjLdqYJKJaJ4zE+lUNy80ICVJRUxwVfEyQY8WBinwJ?=
 =?us-ascii?Q?UyxBlelPWFQWf4H6I3ZcJ8OuloRvmSIWxVvxt4/YVpq2XmxyH1VGU39ulZYa?=
 =?us-ascii?Q?JVSxubpUD8ct6F6snYJjOQ9GUCQUnK5aHmTyiPzj6CjVrk1Pdo83V+sRBAOj?=
 =?us-ascii?Q?YjNFoivCmiCr8OPIA7ElYM9H3bGqauvkPg5BRbahTvIU4NF8gzJafOkK96ne?=
 =?us-ascii?Q?GXnQ+B0z2Ycaz0B/8uTtN0La4KljqrLuaUg0sf4sNzfimpiGdvNkHuDljW4B?=
 =?us-ascii?Q?4PWyxz80ERVhF0kL2bEDIshsVjqY7q+oW5GsLrWnJ3LxJ494tYznF+HZuZB3?=
 =?us-ascii?Q?fFbzVPSHXDCNBcMLYO+gGpLK9qy63v7LWIaD9Gr4CcLoG+sRY8BPypX5C31v?=
 =?us-ascii?Q?m7XTrgHjlwYwEQPa00F31zCZ0jMlIyd3r/Wt1p6231fhdKMvx+rcBAZPzVEW?=
 =?us-ascii?Q?tYpzuuGzI5kx7TTVHbKB3VE2fz8Y1KiatbIOfg5FilWRP4xlbhJ80BgMVIrx?=
 =?us-ascii?Q?ItATzIYpq+nL2N2NVLD3Se/r6pQbtFP1FspH81aT74D+KgBZjsTOkVeDxSQf?=
 =?us-ascii?Q?8yn/xYPwpzW6Oqsi23P3nVMwnAX0C9+1jEdWpjqFvfhLbEOh9nM78K9pd6RY?=
 =?us-ascii?Q?24RvbARjCZViN3hmoaI03ugXfD/qwspnOi6A9up/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3df4318-646c-45d5-1c6d-08dc793996e7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:59:03.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlpXanM/NzgfzcyOZPjqkPnVh5BoDpRK3AeL8BiWwwFDJwvC+RleX3cDlClP5sHvhnrluq+jHp2Eqv66ihi+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9660

On Mon, May 20, 2024 at 05:29:17PM +0200, Christoph Hellwig wrote:
> This looks generally good.  But a few nitpicks:
> 
>  - please split the mapping_max_folio_size addition into a separate
>    well-documented helper instead of merging it into the iomap change.

Okay. Will do that in v4.

>  - judgment is a really weird term for code.  Here is a subject I came
>    up with, which might not be perfect:
> 
> "iomap: fault in smaller chunks for non-large folio mappings"
> 

A better choice for me.

Thanks,
Xu Yang

