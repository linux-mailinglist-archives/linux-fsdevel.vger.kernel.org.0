Return-Path: <linux-fsdevel+bounces-43320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA86A544FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C1F3A1A7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F34207A3E;
	Thu,  6 Mar 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="GsVDVnwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97320766A;
	Thu,  6 Mar 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250121; cv=fail; b=oJKZH4tt3/bJClBL6+HVz1FWTaAJeFjDaXxmphBXrCd2wtGRHiKhAgLK7elfSYzuCbzmayJPVPt0xIIggjd4D25G7yiDqL08g4213csBxqxzFmG1GXjK6QziqVgYpgGvkluypaYyXZAfj3JVLJkBpBkbNE2Sa/zXaRi5mk135LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250121; c=relaxed/simple;
	bh=+fhqlhlCjbjmGHBK0tse1RYryDWpnxOYidc1dU/mBGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=X8YGPA6uNFZnzxH20bHVB3/r5GcLqJyZTdHKHxOns+J8PAc55O3KtgDjMR0nFLuXFngWlaB4klaadl7jSj/Um4Y5bSXXq65t8YMc1uYxshJRnUdzJZ40etKxSrvkRomKHCWPME9GJSaTy6e05wsWehG7I3Jnp+R+wvjyIHRgIUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=GsVDVnwr; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+kSKcLxoNOqipd//KFVED4I1hLIzfL9MRBXpz0jTbcHnpEkw2bABKj3i+vRPbQUJPqUamNZL195KI06YVSNTpx+TVYXPdZoei8SdB2FEZMm97aNLXNv9JVUauRXU3o7/LNpEFjgw6zZeZWWhVPg+o0DXjvku835dMHpDqiQcIWFxbwV3O8nNliaEDAk9g3rdYp0aol+Jp52hgpjpKFVsWSXE/e/EJr2EqCNIDdWB3IJc5v3Srt+VdhxRcg83hPhpOAUgadqbiBPzejWPDgFSzuVs/VyBKnjq8ne8RhBpfBUI8fZHwBzcCTJWKC+JwQUJGbvyRLY4DCKxdeJ7luS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXuEevkkwlvn1/tkw10fnM4mJneGOXmcpYARXh6V/UA=;
 b=Jr9clT2H8hvWlqxiTSJIuXSLU7zt0zlIQVvqAoWKKgJjaLtIU5gpxPZOLgxRPlANbeSd5FM5uTaT24nBkAxTiLfC5YPEK10L1YNVjNomSJIvriS6lp3ZEACgkV3EUNuKRQHv174CkilTxAW+mxVJ36dHNDrykusg7jZDseB8M91OHKh2TiDoVNfz36u3JqBNtetvecKb+DuMDONO+Kk3vQald7G8CCTeoBePs/FzvMJJ7UODDOu58u+AlfBz57jAxP5wIpAXATNOJfTJKMuLX3Z9zRVraifCfM0vpewdY1cWAN46a92eMawsLXQgtwP7ODxVjRgWv1WYnbrKKhaPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXuEevkkwlvn1/tkw10fnM4mJneGOXmcpYARXh6V/UA=;
 b=GsVDVnwrSkvNqU2dO1kIjJojg4nE3o3NUGRIgK70fGurs5aVco9iLbLorCXFeqzMGwnBwvHonohr6dBYX0380yiVwAyHfavFS3SKovpUEvcaHo3/a0A/INotn7JAF8gvV4zak8/RvM/YcyMNYve5AqR4A+UERQciP2TD+1DHu7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by GV1PR10MB8520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 08:35:10 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 08:35:10 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Mateusz Guzik <mjguzik@gmail.com>,  K
 Prateek Nayak <kprateek.nayak@amd.com>,  "Sapkal, Swapnil"
 <swapnil.sapkal@amd.com>,  Manfred Spraul <manfred@colorfullife.com>,
  Christian Brauner <brauner@kernel.org>,  David Howells
 <dhowells@redhat.com>,  WangYuli <wangyuli@uniontech.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>,  Neeraj.Upadhyay@amd.com,
  Ananth.narayan@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is
 still full
In-Reply-To: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 5 Mar 2025 06:40:38 -1000")
References: <20250228143049.GA17761@redhat.com>
	<20250228163347.GB17761@redhat.com>
	<03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
	<CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
	<CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
	<741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
	<3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
	<CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
	<CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
	<CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
	<20250303202735.GD9870@redhat.com>
	<CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
	<CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
Date: Thu, 06 Mar 2025 09:35:07 +0100
Message-ID: <87cyeu5zgk.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|GV1PR10MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f56439-73cb-47c7-d4d3-08dd5c89ce3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WhSI+eelgz49CqSU5XyjXJNz7V5NPx7VXV/Ls6uzy7t4yF5K+E/OfckF3D/T?=
 =?us-ascii?Q?unwOUAXAP9wmAKucaiOxNPfXq1K7COzeoLPEQ2VTZfcHYLZ8OXI4hmNziAIh?=
 =?us-ascii?Q?MXSngfDmZCjyQAxYpQqOMt2t3dF8nOTgoDUBuKWjsnqH8RDfKlQZp783bq+P?=
 =?us-ascii?Q?PHXdKvYUjgSLkhFLszkRvwhYHMZ7gMMOnKdsAm1gISR13HSjZqfjESpXS3PH?=
 =?us-ascii?Q?XxVspYmv+DtrMUODbzlVhelhYjVkFhZyJI+b0ZuSN6oV2hzx6cUs81QnRMqy?=
 =?us-ascii?Q?BxXSh6DNPtBRDuhIx1VlvD2+IhVJsrbUKD/OCuWhAPWUPd+GBRDITcaD/6S9?=
 =?us-ascii?Q?GeS3whkVyitnjiawNqgeqcvT+JEgU1hryAw2WEben/66vcsWFfFD+pLasYAY?=
 =?us-ascii?Q?X8mSV1S4lb0r1ociXuckKLDaRWDcNixAiP2mpctEQBy6OvxF3TOE1T5PXdQk?=
 =?us-ascii?Q?Tml+nH6FsdrExpWXNxtd42aPwpctg+UdyuRumuloTWy7tOEg57Y8xl6IB/si?=
 =?us-ascii?Q?8HDSawOmlwzpW/WbstH8gDxxFepjUZzx8Ol0xJuPH9cv+kvBElFRMT3xfzqY?=
 =?us-ascii?Q?Lxf17KyOx9KXVX3VHTSmS7Dv7DqFElesWPSxYty84IKgOdK9JxILtkVs8TD0?=
 =?us-ascii?Q?e0B3BDyYBmOonVJg0jOWqQgGUz73Xlk8Z7dvnci4pRIKf9Z/iHofaDW3pkC2?=
 =?us-ascii?Q?3OWpDJsuAkR4qcQYGw3KU+GNbtjhi9ACeMfMQMqi/KHfet6hiKfudG4cyTRg?=
 =?us-ascii?Q?NGJRJ/x/cXkX7t2jGLsWEV4DgIr/LcRXnOa3g18fSBmiMvSF6p7fhEvxyxns?=
 =?us-ascii?Q?EXKjpztdRFUJVDW/A6LTsvMhz72rAL7haubwmGu9MM734tUAsEQEOiatcwlc?=
 =?us-ascii?Q?CG6AOsXc555J8U9wuohc7BZF4acVeteHllNk/5R0zUNxcCuc+9j9H3wKlxnF?=
 =?us-ascii?Q?s6/iz4l4RA+pq7tN9Et+Itin1R9PnhIxP4oQ8TD8hi37aFbQSUe6t7kMV3CS?=
 =?us-ascii?Q?pRWKlUoUoihHtA3XBm+NCB8ea7OAHtBtJHwqDNsaH0qXLIdMcvBnRv35+gvi?=
 =?us-ascii?Q?TgauizsjIMdyovt1leUa9MU17zxQEglkLaYFYUGFRMEDPOhYXEIJRxNfR1IG?=
 =?us-ascii?Q?9S6+DHjnDRjmiKQho/pbFPvwy5NKuKhRvuOpluRuU4k4m/J1QNiihDtFn6qm?=
 =?us-ascii?Q?wB+2m9xQ/cgb6VCJpASY4sP2Fri5wOCOA1o7g1wOKcwQGB28gLaAFFJsG9dG?=
 =?us-ascii?Q?PaQnQOtWtf7kg28iM2/h1eeQ4tiugHyyfyn2Ug7OW9zfXtHEJjadb41aPg0h?=
 =?us-ascii?Q?79hKBCNfrgTJPlgzrOje3SKK8z89HpGO4HON9334+HLfMywVFX/WaXjihzzg?=
 =?us-ascii?Q?D3VA+UvFLhPKvQOfYkWfeu/fb0J8ZRGllLnxqFJTNLTJSvqqVp44lqpdiwOx?=
 =?us-ascii?Q?RIMfPPgla7iYTAwFGxhBQp3CxrwBznJA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1IY7eNN8JngTJgfTgBPfItEmFfvdbqW2J0VhEL4/BQU1nPVSwarUmTx+3jBb?=
 =?us-ascii?Q?5fpkE0zVl6cAPFGFn4B5WycfCMzyUHYqNATljyNGHpkrLxRhEAHPbEFDCqLI?=
 =?us-ascii?Q?+KNIeraWt3FctS1cn6hBkm0tycTUUGlLyQ086UuouwRdgCoqhEwZ/jfwasVd?=
 =?us-ascii?Q?BZ+8BclDN4+M8Vazw9YmQk8zKSr8SJqBlrD7FF3TBQufbujGpO8+cGcCb+8Z?=
 =?us-ascii?Q?ICAG6B+71mHSNJ+lKTEW9190o14rcko49S3mnS8WEWFhzUfzVR9bN0NERr5B?=
 =?us-ascii?Q?vI6FjFJQrvFIk3iCO5xG9XL4HtjZVV5RJUgDrk9dczDPTmWM8B7zNbFmbApg?=
 =?us-ascii?Q?wRtd5rnQMRIiKmmGz7F38DxJ+Tz/FYgRoamdLmDz2DLgmAko5xO3Hawh8bnh?=
 =?us-ascii?Q?+hekiODhMhZEJPyXZckbJ2743k5GRSaDp/dvjACPCvcEMzXDRbhNQ0+5xpPY?=
 =?us-ascii?Q?R8FYmiamCdXBFfftxiUxikoY42NrK4dR1/G8vrG7aIqQzv4qoe7pkVYyRpMu?=
 =?us-ascii?Q?MAAwVNN2EtFYm6QtInT2EQRAeaUg4mJN2pyMhZvJ5R6Sie/lI1+lQLIBEdwh?=
 =?us-ascii?Q?0tiGOpmK0L9zg5qXRKCUgOX4qAWNEvuvWLP2pGJ10yyI82cx7J6VUDDBznCO?=
 =?us-ascii?Q?urNm5qKVJ81dd4CTmyq/zaUSlS2Y7NOH9bKQkKgnaz/VGfDD4P/2UR8DQN3F?=
 =?us-ascii?Q?D9MtdaY9v0apTCE3Ox5ZbA438VYafUlV0Ger8IS62Q65QtT93rC/4dZfDWtx?=
 =?us-ascii?Q?d9X8wOImFxhOnUhwitp92e+rVCFBObb94DrlJybTzzHyQ+GqBcXh15bPIAbR?=
 =?us-ascii?Q?93YADLrnIk2DG8xLF5l3L0dAN7BwDXvo04EdFznUkBxJgDwNuqH1VRIUEUvX?=
 =?us-ascii?Q?wFLG+XzMYhgPBqLtPiWnON5Cpjy84ax1z8lmKcULt6V2H1ZBaZf7LzniZHr5?=
 =?us-ascii?Q?BYHiW0KsqIGLHMsvkqeCJuI4R4zAYNXkymubKu0aWje0LbYmeP5SD+lR7PPH?=
 =?us-ascii?Q?hjVVp0iX4A0PQuAITWUUjbW65SmliuUFFtL6Ife6eLGMKQY/bf7u/4g6Zgz6?=
 =?us-ascii?Q?/3T+Vh4sNK1FRnNGC3xzvwWmQxTVHQJQbjSloMwTKTTsJcB47WOpgP2PL4Lj?=
 =?us-ascii?Q?uRBWugcIaSlxKexSwYbN4EaWvCefN7BD8DGXC5HenLAd1PyKT+0sahlnFzBm?=
 =?us-ascii?Q?/j2/Q5DCd5tpkkqEeU9O4Z6pQ24EzHMtn3AKAUI4a+aEhxEou24K3sQIjJNm?=
 =?us-ascii?Q?cmU6Ab/f7yVzu4pTC2Abl3XDSQ5CzZqLb3WTy34bE0oKZxjQDnK6KmN/Z6Iy?=
 =?us-ascii?Q?tjwcJzS8U4FM+Hl84fIlvheo0F86CJ/bx1p3bD0I965KLF7zcPn0bDLq2qRh?=
 =?us-ascii?Q?lROfo+obZEq0cu5v1I7A9OXUQH43WarQqOa6E9TtLzvbheuwb2f5zeWGggYo?=
 =?us-ascii?Q?9PHsxzwghHcfFji8ufi9aaTRfCGroJMhTytB1hicnubFSfDqbYKMCKFHwf7P?=
 =?us-ascii?Q?rUAttLYbB6a6RaNInrNcfuhiDSyFNrrcrrvFmd6LuBpJYby3LNwGJ9P9AJp3?=
 =?us-ascii?Q?0aXmemjp8vAL4SoJ1K0PABdTE1rrBJMbLXlFAlk+PCnQaTIVVjx0Z0/mIUlg?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f56439-73cb-47c7-d4d3-08dd5c89ce3f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:35:10.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TBAvXi0A0eLxAmPjH64U2r97foG1zsXbuF2WfxBSU6iKKCiT/D1i4LR5kY8qYp/+P2M0j0/np+XLBMCRNik5L4SB4xkVq8EUZzKrZLFcFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8520

On Wed, Mar 05 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 3 Mar 2025 at 10:46, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> ENTIRELY UNTESTED, but it seems to generate ok code. It might even
>> generate better code than what we have now.
>
> Bah. This patch - which is now committed - was actually completely broken.
>
> And the reason that complete breakage didn't show up in testing is
> that I suspect nobody really tested or thought about the 32-bit case.
>
> That whole "use 16-bit indexes on 32-bit" is all fine and well, but I
> woke up in the middle of the night and realized that it doesn't
> actually work.
>
> Because now "pipe_occupancy()" is getting *entirely* the wrong
> answers. It just does
>
>         return head - tail;
>
> but that only worked when the arithmetic was done modulo the size of
> the indexes. And now it isn't.
>
> So I still haven't *tested* this, but at an absolute minimum, we need
> something like this:
>
>   --- a/include/linux/pipe_fs_i.h
>   +++ b/include/linux/pipe_fs_i.h
>   @@ -192,7 +192,7 @@
>     */
>    static inline unsigned int pipe_occupancy(unsigned int head,
> unsigned int tail)
>    {
>   -       return head - tail;
>   +       return (pipe_index_t)(head - tail);
>    }
>
>    /**
>
> and there might be other cases where the pipe_index_t size might matter.

Yeah, for example

      unsigned int count, head, tail, mask;

      case FIONREAD:
              mutex_lock(&pipe->mutex);
              count = 0;
              head = pipe->head;
              tail = pipe->tail;
              mask = pipe->ring_size - 1;

              while (tail != head) {
                      count += pipe->bufs[tail & mask].len;
                      tail++;
              }
              mutex_unlock(&pipe->mutex);

If head has already wrapped around, say it's 0 or 1, and tail is close to
65535, that loop is gonna take forever and of course produce the wrong
result.

So yes, there are probably a lot more of these lurking.

There are probably not many tests that stuff 2^28 bytes through a pipe
to try to trigger such corner cases. Perhaps we can help whatever
automated tests are being done by initializing head and tail to
something like (pipe_index_t)-2 when the pipe is created?

Rasmus


