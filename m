Return-Path: <linux-fsdevel+bounces-74160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED67D33268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 766EF302697A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9003334C30;
	Fri, 16 Jan 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Pff+AzCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020081.outbound.protection.outlook.com [40.93.198.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF730DECE;
	Fri, 16 Jan 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576745; cv=fail; b=V71+ebvQvBFUJy2kcWOwmAgXi4XjZR4/t81Q6b1qiNtmKqKbRl5yHgbg5zG2SU/4dsl7sh60vbNdpwbhCR9J9sCuIXbfT3MwFUPaf6GgGtuEJ5amB2bF5x/cGRKzz78LxGf7L1yRjHABBrAjQN7nVQPD194enWQPVrmLXFyItvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576745; c=relaxed/simple;
	bh=toQjk5PsjYR8hfVxi15f9gT1Pn/hvL0NMYihB7YF/+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpB2OOyU9gcO1GwyzR/lUbXvU/+uoLe3/IacPxA6Tg1BZVRMAOb1aFniqm5GgHHxnCBM7eZWfWpvzpgIqC2cUu11MeErL9DSWtWhhUPKIWRAVbkLyeBB/kULGF+QsZCpZ+ZvBXXwCqTfEBnkJBWI+pTAJHCV2gPmIFt8yiY13C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Pff+AzCC; arc=fail smtp.client-ip=40.93.198.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt+6KzFnlDCobgDQ2dxWrc0VHB2DRX+K3Vu9gOTv4k1RAYvj0zPOrSLnZ4Z0docua6Wf4s3I9x16xp2MyuVPYDam5VY+BKpQArEOD0yDErrUEmc1/cvjKfj4JKxgg+2ZTNlhis9AnBDaQRQ09t9hVZLAIk4pt75qPcCxHny93hcQaieFeYJih4qIbUKha3Q9UuvnQRm+YFUhZgvKIvHRvGZ8YPNvsvLVDiKIcberS2H0Ip8mCm2dM5dUfXCYvTBlMZEdUmc7PXTIfI7iI+EE4LfnxuVjsYuvWw7kOCTENAidTJF1WvjnDm1SKLSRQOTfzgPLQ9X5YW1AYKADSa7f8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbjso9D6F2WHDtaxT7qYQTImEDFuCGiwl5rMmFO24tc=;
 b=cPXUeIobRY+OVvUfv16Is5Y1xPyyx7qdTqzdYhwrp6/rKbHQagO0eMBaIbNagb6E42cJmPSRsaFBpxCDOOF9U7DugrLBLSqEtAsVodsmCjwf+A5qSSQKPz6v+stk+9J5Ih9WG98JGaoBUW4PGyPeAy/Wx1CpLDuMubnwOJh84gI+oyodqfkidwFODYofCIxv55U7H622pMKyOn+z/Y5kBjgOSi0/qOdvheM7YQk1LngZEM4TDOUgK4O33DuyIpjzZvuEU/2yOrkivQnFLDyX+PQ0NC9wZU+G9WqO1JATXxFve9Le7tCeVk/xtvmjP1DgXvrAP3o1EfyVOedlbDLmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbjso9D6F2WHDtaxT7qYQTImEDFuCGiwl5rMmFO24tc=;
 b=Pff+AzCCZjjsE8eBoq1b1WUaaz735FiCHC2l9p+q4kZGUbRnuqH5oUp6fYNd9tCSEJQdiQuoHwc45xkAvpJvvdIEjJixKqLJaUj0MpdhoxWF0p0CpPv4eizpO+ExvDfr19XrlKcJV9EeGN6XeyIF5c34IsH3Qq80ac+yMyxAlRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA6PR13MB7157.namprd13.prod.outlook.com (2603:10b6:806:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 15:19:00 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 15:18:58 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Date: Fri, 16 Jan 2026 10:18:54 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <AB5CB215-13F6-4EA3-B4DE-A43105BFD62C@hammerspace.com>
In-Reply-To: <3fc1c84e-3f0b-4342-9034-93e7fb441756@app.fastmail.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
 <3db40beb64cb3663d9e8c83f498557bf8fbc0924.camel@kernel.org>
 <3fc1c84e-3f0b-4342-9034-93e7fb441756@app.fastmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA6PR13MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bdbb01-3b63-49da-d072-08de5512924a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1epB8ppWpkORSIbgFh//YhdGLb2JWEHyt/uOhdAaO/S/2u2WgRe4ivIF4cPe?=
 =?us-ascii?Q?7j88Qmqf/lDcMR5MYWPJ+GbtHBQevi3jDkG0Pg+KvqALdykV0+N7JpVC5cAX?=
 =?us-ascii?Q?0M6gUr5L5N/8vjq5SK1T1DzmQKuvJWyUzcA4ZzM6KO1oI9NXE7nFLQ7u/OcB?=
 =?us-ascii?Q?0IFgBrwOqUPDQNg42nIvc3CFZkU65SVwaLcVl1vIPwYHpDH80gWIoBk6XgxW?=
 =?us-ascii?Q?KW7P01l1xW1K/Vo3zu/cW2jVRqtA2AGGIsXkzHExONaaertzoX2ifbsGbDUA?=
 =?us-ascii?Q?3dnWFGx2ZhY9R1YPK/gck0G065ZUusrYI4lks/hTfDcicQ6ZEdmeWtbyQkib?=
 =?us-ascii?Q?zUai08KWaKgaejD16hEDdLufKvfrVOFfpVeHZ+nUojlqy76ep5ODSa26roDl?=
 =?us-ascii?Q?IO8MvjKfrqLJ740qZpmRsY5HMzYdEWtgMFZX79nF8U5riklf/7JJR6QYBiut?=
 =?us-ascii?Q?+GAkGVm1KRxg/yNOzOwPCBPUvOlwSPC5Ugtiq3zl583UQaImMUsBui7l2Vf3?=
 =?us-ascii?Q?QZNGm/dkD6f+nfJ8qRa1H+e36TP6/y1N6Zr+ZdmFSgoPNKZjvLQK9YfM9L5g?=
 =?us-ascii?Q?PGipNVfrwqRzaluy2AG7633WTbMOXfskopXFrY4JT/TKKD3dhdXDEwhjoOGR?=
 =?us-ascii?Q?aGpa1TgJD+IIkaeuQppmrlOBRPr7Y+IEpG7pQsAnPzXryXLcbCPKwOPli7tQ?=
 =?us-ascii?Q?DcJdLbJBdFypK8HyNrmrNQIFaLqDd+Vub8PGU6yMXkBYc3Z4xYN3zZnUcbXw?=
 =?us-ascii?Q?aAJjkI0D4HVYX5gphFCSAenxVHqulXSsDGGB8aZVDHGfh9fzRjdSlugg5rP3?=
 =?us-ascii?Q?/mbsdsoXCJkgTAC3niiEJEw3qnqq8X4onV/JCxRMJa6KMGY3gb/nTdvJTZZr?=
 =?us-ascii?Q?32dNFB/tWIAo8bfnfiH0XVZ1m4916uurPjx9tZTPI/KzzIciDxpemudacd+E?=
 =?us-ascii?Q?du6cR4j0lOE7gIHpGH4OmL0/Z8CEovDbl4xisMpPar8WLhf6hK6CrvDNkBiP?=
 =?us-ascii?Q?uU2PHEnC3UlyY+mNX5uYFtaVd+17oqZQITTLks4kLOYm2QZcw0dvRZhj3o09?=
 =?us-ascii?Q?hI1it1zfqTJg119MpF8yDQgSeL3Nz5tDBO+hA2CXMSdiFfwyLfRj6LsktZAg?=
 =?us-ascii?Q?O2SudXGSgCbMNlYgl5fTRMUhDHdt3eZS2w0LQU0zpFZ9YUDCkkZl36mdvEgj?=
 =?us-ascii?Q?3xDFZV/tjhe6PpSlY2CxINoft8tvwt5kOD8QOj+htSpAQjks00BdBwHPvX+S?=
 =?us-ascii?Q?bHa6uHCnh2p4fYEMfqjDq3zQq4dH9JmNSCILQauxmgTSp1I2rkwZFP3DqRTd?=
 =?us-ascii?Q?6W+BTgYt3auedAtRni/onh9vRi+zicHgtZMXCcMH4Ac7dKTRPWhtp9POL9b4?=
 =?us-ascii?Q?RH1DKrbLNNzBbI6Go49I5oOo2ZKs2YCId71Di0dEtKAFkBhH8AL9aRO/nE+S?=
 =?us-ascii?Q?G8fELAreeaT1mzDAUk2zuDXIbJWVL4kEPq9iJ60/c4FT3Sa0ZhFC7U0sX9H9?=
 =?us-ascii?Q?8BaVIZohqzYgrYynaUyTwY79s6ZyNRVvSzaqu1B1r3xSfpB/B0yj7P6hzZC5?=
 =?us-ascii?Q?l1XdoBLtcExC6lgG7uw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+UvCQVgqulHiCngtxsyboBQIxwrzoWtG6nTM/H1n+SnOSSpCF/xh5TnffgE?=
 =?us-ascii?Q?O5nUxuqsOjiUUhkW3E8QRCFsiQ9zPpXHRmJp7IKoN2Lk0Ua7T2sn1IOR+MfQ?=
 =?us-ascii?Q?L6XJDqKFcH8gYcDRMcBHUvKp6q67CxoBtTVfzT+98kUpH7lp7SSOH2DJ7lHy?=
 =?us-ascii?Q?qlkOSaFlQZ9eDpReKALBSpPzdWXv4qln9iyTSp3phFl3lGCbI6dUo7Ali3YS?=
 =?us-ascii?Q?5jUYwcyUCBZXSQbaO9F7ynkjFt5DIEYOY/S1ENVZu7bNNEvlV9ZSqAtg3ySN?=
 =?us-ascii?Q?uCyq4PwrTBXzmW00gdUmGzZRnM6M7vZCoj2S1rnTWOkQ1BtjX0tdzCGa8i0A?=
 =?us-ascii?Q?7n2oQ2i2on2lT1AleNY5jFn4J8RpsqzM7iMBz6o5VaNokXaOZN1C2mpyNI59?=
 =?us-ascii?Q?heEIWaHfHxuVxWBTXAe1G4U61dKfIVKVDyOuNieIGhqqiee3rpBpG2EpouBu?=
 =?us-ascii?Q?xSS2xa1hkLwVXpU27XK8dPm4u2S1U/OJ+vv0UwVqgaXCo+EGF9TOcCpTKhra?=
 =?us-ascii?Q?QIZWcP/WrtHdXhcybJ7Q53o9VchBdGxu6Eql0dvzqygd1+5wF+H5MFR8ToF6?=
 =?us-ascii?Q?LmZERZIZRVSufRKg8vas3UeRcEDw1iS2K/fU/qZ9QvZoAGSbwchU24xuC4xj?=
 =?us-ascii?Q?3tG2DUyZwVcuQytFw7FhqhoIVpydtBXllyyA/uzya+YbRezzbQ07f7yimC7D?=
 =?us-ascii?Q?W8399XZxDw684c+av2v5pc3HJIoUzhiRqHVQKs/SoRIA7dLeUPSGBUt1DpWn?=
 =?us-ascii?Q?CvuQA9c7UDnMwk64UClWYJJ77iYeNM5YfREHs6MG7lQ/50KrBbBOGQ7lbtGP?=
 =?us-ascii?Q?0MJgcEfzzGCj2zxgMxxfJVU/IyeAb7u3O08HqMJWz4j1PCTGTw1u2DTTx0hZ?=
 =?us-ascii?Q?WCFvs+4y62FW3lJ30z+B51TrAJTr3tjusdLSllPpmruPeNxuJDWQYk/iPVe6?=
 =?us-ascii?Q?+hlRoG9IlLWnHx0jmlmmdHknjdQQJhaldcDY1EgoSKZayjOQCwGFB8/fzm5A?=
 =?us-ascii?Q?cAIqRvQpTA4wiukrc8sbR9UYpiBNpV8u5U51IuUEX3dsPizghFwH6zF2CpBw?=
 =?us-ascii?Q?6+m7bnGIFifg++uNzvhifGArVgq2dijKVaEJPkzHiAsjL8FkrgTGappRcBk2?=
 =?us-ascii?Q?H2kHpi+/aRdv8NSOwMyIksrfWoz00CURXuxhUA2va1duUf+iZVa89kaDF2kA?=
 =?us-ascii?Q?KOmBB47Xu39Y3hmTHjeUM+02ntNTNfKRHEV3CNLwRai8jBzHK+L/FKu/Ut/Z?=
 =?us-ascii?Q?bxgDpnYmlnPRYBNg9mBSoDCB4eIxPRXXLeE7LgXE87P18+1TnYNJNZKzghrr?=
 =?us-ascii?Q?8GlnuTuTWPQrxenqBWJ5ouLl1QJSohOXVFwA1fdsiPPZjE2ZfqsW6EDpOKHO?=
 =?us-ascii?Q?3h1eU9Ksa4tYvdEeLKcJdNbkddHsJERm5QNYSpADLqkWjwpGyoTUzYmnqZ17?=
 =?us-ascii?Q?9DNGbK1FLbqJ3Kld/dNPzWBrYf57k1IgAb3xsJNzk9ZTNFk+DhELXNoTTFLW?=
 =?us-ascii?Q?hjVBbUSLx9NhkzsN/27hZwqKy2SmUo9PXzyPmeimcrhRsyiIFj0wMVbtsaWW?=
 =?us-ascii?Q?V0/xjJahtU0ZZ1xj+Fgnmzafou5yCvR5ho6IxMIY+EZD7syTrlzxLCZO830J?=
 =?us-ascii?Q?lJ61oP3rs0EmEIo8OQVB3zKtIiW+VoVGsOebWYYjU9w0zFggaqvOFcQk1B3v?=
 =?us-ascii?Q?L14jOtgHoIE6mE/H3o4f33ABk9yMFCSei/6GPwfVWDSxtSqB1u5lLhG1+n5f?=
 =?us-ascii?Q?EHtXJCGFPv2Az0Y3VzCtT9iVBaR7emE=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bdbb01-3b63-49da-d072-08de5512924a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:18:58.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djvVMJ3Q/k39ynXJtzFJPCR+B+1mNWWVFO49eS8MOw6W685Otyqy3pezE8cpwKf9Um0oq3B4yk/WJtUxEbNWirY6ffhO8l3bpoUdsmFxmOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB7157

On 16 Jan 2026, at 10:09, Chuck Lever wrote:

> On Fri, Jan 16, 2026, at 9:59 AM, Jeff Layton wrote:
>> On Fri, 2026-01-16 at 09:32 -0500, Benjamin Coddington wrote:
>>> Expand the nfsd_net to hold a siphash_key_t value "fh_key".
>>>
>>> Expand the netlink server interface to allow the setting of the 128-b=
it
>>> fh_key value to be used as a signing key for filehandles.
>>>
>>> Add a file to the nfsd filesystem to set and read the 128-bit key,
>>> formatted as a uuid.
>>>
>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>> ---
>>>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>>>  fs/nfsd/netlink.c                     | 15 +++++
>>>  fs/nfsd/netlink.h                     |  1 +
>>>  fs/nfsd/netns.h                       |  2 +
>>>  fs/nfsd/nfsctl.c                      | 85 +++++++++++++++++++++++++=
++
>>>  fs/nfsd/trace.h                       | 19 ++++++
>>>  include/uapi/linux/nfsd_netlink.h     |  2 +
>>>  7 files changed, 136 insertions(+)
>>>
>>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
>>> index badb2fe57c98..a467888cfa62 100644
>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>> @@ -81,6 +81,9 @@ attribute-sets:
>>>        -
>>>          name: min-threads
>>>          type: u32
>>> +      -
>>> +        name: fh-key
>>> +        type: binary
>>>    -
>>>      name: version
>>>      attributes:
>>> @@ -227,3 +230,12 @@ operations:
>>>            attributes:
>>>              - mode
>>>              - npools
>>> +    -
>>> +      name: fh-key-set
>>> +      doc: set encryption key for filehandles
>>> +      attribute-set: server
>>> +      flags: [admin-perm]
>>> +      do:
>>> +        request:
>>> +          attributes:
>>> +            - fh-key
>>
>> Rather than a new netlink operation, I think we might be better served=

>> with just sending the fh-key down as an optional attribute in the
>> "threads" op. It's a per-netns attribute anyway, and the threads
>> setting is handled similarly.
>
> Setting the FH key in the threads op seems awkward to me.
> Setting a key is optional, but you always set the thread
> count to start the server.
>
> Key setting is done once; whereas setting the thread count
> can be done many times during operation. It seems like it
> would be easy to mistakenly change the key when setting the
> thread count.
>
> From a "UI safety" perspective, a separate op makes sense
> to me.
>
> What feels a little strange though is where to store the
> key? I was thinking in /etc/exports, but that would make
> the FH key per-export rather than per-server instance.
>
> That gives a cryptographic benefit, as there would be
> more keying material. But maybe it doesn't make a lot of
> sense from a UX perspective.
>
> On the other hand, some might like to manage the key by
> storing it in a trusted compute module -- systemd has
> a facility to extract keys from a TCM.

I'm hacking out a problem in the nfs-utils patches, should be coming soon=
 -
but if the key is already set, the utils don't halt or report an error.

The patches have the key generated by hashing the contents of a file set =
via
nfs.conf: fh_key_file=3D/etc/nfs_fh.key for example.

No additional crypto benefit for having a different key per-export, becau=
se
the filehandles start with fsid the siphash naturally computes differentl=
y
for each export of a different filesystem.

By all means attack these points on the userspace patches.

Ben

