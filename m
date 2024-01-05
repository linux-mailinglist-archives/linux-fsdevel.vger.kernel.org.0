Return-Path: <linux-fsdevel+bounces-7442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D606824F29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 08:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91B32852AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED13A1EB3D;
	Fri,  5 Jan 2024 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="JETk18fz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE51DDD9;
	Fri,  5 Jan 2024 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF1lY4oeGr3LBwJk3ZR7MWAeP9SrHHDK8KwoL2RmjCFN8+3vKuYHETzABjdJrU4HU3+hYvtSPUTXFfulW3e1+MjDWEJAhC89Kr3d7rBWGU6OkVs6eO22InnMd5Omad5uRSfTiNz87cV0onIPBLWG+m6bJS34uo8OmegsTaN6MHyMRc5PKB6N7lxCxpxXcqIxh8/nWC3H6rDH+yoU8FjfDHZ4BLbokj+zhxgGdUAsior8jnhen7Mp84vp8ZogTBrf4S0YHT12yyTY7oClg/Fe4kE8CiLKXbonyWqqpV1M1KM5p6k04cq7SFR6ZHS5e7IfzF1YfnOsMmjMPtwR4mC0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a5jw1QyWuTRkjCthL/JXi1g5xzyEK1LTY6GX4CW0F4=;
 b=lVSPzoBXvNu4dnmHSMzrMTgVzXec3KgELkIDUFuDw0hQ1shwqKXAPCAhajQRym8yLwgO7NeMPu8f8r1Hb2Og+37YKIjOx1ta4FRUfbe/RHqCBp3YfNp73vY0sEeyB5sFa4hs0WOpz1eJ8QTDY9t4uulYgEHF8loQEmo/Qn4bfFAgnTcCIp4ELkVsni2gZAbaVDwnAwLiyk5zwbJ7Zh/wRFw4SrNCBt4CPEAOUDXQzWWUEMqEYoc4JuRHQ1VoACpNjfcrvn1onTeej6AAjBjMNaBKpAvTqQt9ckGTELBBcfbNMHhoKDBdgo7n6J1amO+0lPrEtJE4YxyfNHlBi8vKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a5jw1QyWuTRkjCthL/JXi1g5xzyEK1LTY6GX4CW0F4=;
 b=JETk18fzq7zTgUcBzjp3EQGNohnVFYk7r/AfARowYdGAFH0jsOX97B0AfgAW01ZKoCK2i5iR/eL2Nhc3vtEa71EFhRddiedxnX4PngF2xnX2LmDisLBfoFkZ2traiDHSKvM3ZOKR+eHyXrSME5H/sUn1ppmqC0Ybg5XCVHwtR88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from MW4PR17MB5515.namprd17.prod.outlook.com (2603:10b6:303:126::5)
 by IA1PR17MB6051.namprd17.prod.outlook.com (2603:10b6:208:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 07:25:41 +0000
Received: from MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::f5ca:336b:991c:167b]) by MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::f5ca:336b:991c:167b%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 07:25:41 +0000
Date: Fri, 5 Jan 2024 02:25:28 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
	tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, corbet@lwn.net, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v5 02/11] mm/mempolicy: introduce
 MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
Message-ID: <ZZeu6DwVt6o0fl14@memverge.com>
References: <20231223181101.1954-3-gregory.price@memverge.com>
 <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp6ZRLZQVtTHest@memverge.com>
 <878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZRybDPSoLme8Ldh@memverge.com>
 <87mstnc6jz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZXbN4+2nVbE/lRe@memverge.com>
 <875y09d5d8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZcAF4zIpsVN3dLd@memverge.com>
 <87cyugb7cz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyugb7cz.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To MW4PR17MB5515.namprd17.prod.outlook.com
 (2603:10b6:303:126::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR17MB5515:EE_|IA1PR17MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 434657cb-890e-4de2-0fad-08dc0dbf859c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+YG5GtjxzsjUdbSwdpFawOUDfo09ZjnArb7vqpyVPaOOCZ+C8JdN9DspuYFilOAw7alk46jTktTs7BQsRyXWPCh5BlF4aFzatvcpCTAdvG7P/i2WNXKRkvDIfQFe2VEaG8oILlWiK/yW4ODtOJbqCdZFZ/fP48y24rpQIl+0mqFN7Sq0/BmHAvKJnSp/p58hVSUz63mhcPP7Fl6LSu5u8zSXmEY8aaAcNReXvIy4r8uusMnv0a+2pxENTIpIVideAD/+q+SXCKPiWVPOkzQwMi8Bhodk3AInKHa9qKgag485TcnEJx8QnoZ1kE8gHl8MfGLqzsll4gvCInXK2UedndkJQUpOP/fwXrwdSwXGc/anMYuXCf6WhGMbrtIUp8IN0bMWTyE4PpvfKknQ41baWUmvnh8NIBKD9b6zfdqC/EABhr7wR7aG2Pm49FeGFf5kgxgCPS/PVfiXl7ARypERJxjcB7bNOe7QYv8OpnNgmGOWhFmnMbP18oAblXnScFktduJBbIT1VvNqdn2K2cnKGglbPNyX3qZrhSv9JaMmFWJoLIMekfwP93OelMHX+g9qhJiRLMfWmhF7keOlnFCpliywPDFlrHjCAMSium4MYVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR17MB5515.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39840400004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(4744005)(8936002)(7416002)(7406005)(8676002)(4326008)(44832011)(6486002)(36756003)(316002)(86362001)(54906003)(6916009)(66476007)(5660300002)(478600001)(6506007)(41300700001)(6512007)(6666004)(26005)(38100700002)(2616005)(66556008)(66946007)(83380400001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LkNWQ16ILwTN61lgtsVuTnQfB7PTjCEsWW+t17j98K5ZV09kDx70XY/Dz/mb?=
 =?us-ascii?Q?yqTjtud268+QBjNDyupxALlkVzkuJiNkxyZIsE60n8fJlSvM9dJtCsRktU8G?=
 =?us-ascii?Q?CRr5yJtptI5bz8EegWWDVjZqdsj5RvjY2whFLEUo8SIJE3RhMbCS3/h8cj/R?=
 =?us-ascii?Q?Z8kWOwyLmHPVuCWsbUO7e/eape/c2QtCyA9ghod4XHxnDTNBvH1GJ/zv7+q9?=
 =?us-ascii?Q?UBCUTHFWzhyL11FsXLZiS8Y2pgVb6AHAonwRnW7amsBpcr2hyfdBTL+JdvGZ?=
 =?us-ascii?Q?eecBOciWYHFq25GEK5HRLvc2GBetbyTirKIpsyieaPho7uagj3lNNopvnLdb?=
 =?us-ascii?Q?1njYoxK+qLe2vKJbUWMUy/fqugxD+2N4k2Ht3zJ/UIA6TUV/MVjZlbxKIt/i?=
 =?us-ascii?Q?JFevkLic+7ZvRSVxpHgUdRXR7Elp7aYQYZtWVjTtqgUf2DljQHyG5sSSGhoU?=
 =?us-ascii?Q?3k96uWSNgzZhuhnfE7mGv71kScveFahPNwCQLz1Gj3I65Yy/5LlTSR96yq5g?=
 =?us-ascii?Q?+3uf1R3487+YXzzbKR8thXogknUoF2eAI3qaAhO1rEzXwass61gvJHdvPh7l?=
 =?us-ascii?Q?w5gDKbmRBPlo9eBsbaghq17C4ZjH8i7iiwbxBV2zypuSoUMf+6qRsrabhedF?=
 =?us-ascii?Q?PmnmQdul3GCummEiQpVHWLZXlJq6ZNcuhy7MrE9dVWkzUAeJrcdPXqYVzrWg?=
 =?us-ascii?Q?c9+VRh25Cr0oge1wbAeqMzpEnsUSkmmjKMjHS0GqsJifE9jaddqfnFQw22rV?=
 =?us-ascii?Q?wVRpt/jDY3aPUrKQiNU1y32oYT/piIifczDNZSnW/GLISgRwAz7zyLllF5+S?=
 =?us-ascii?Q?xyFsftKAzfu1kIvtFXytzBFGECiEy6znMTbXwZZuRx67z0D6UtfsBBza0dVV?=
 =?us-ascii?Q?IAAXRNQ3KuaAp3JIHQlJ3wwy0OKPZx81X4FwQ+U+p6vekV/7Lx/Cp71Hk6e8?=
 =?us-ascii?Q?L27QYzPewcyRKpidT2IR6YaGjZ51NsM1Q+6IRO+BI+0NrvUH3lhoYsgm6yCp?=
 =?us-ascii?Q?NskRv2qegC3j49WQ+KIZZWjit0N/qUPiHwc/r1rldrNsvScYzFWq9PPsbIJr?=
 =?us-ascii?Q?kQiAl5AySUTKDx6pJuBK1gY9N0Wk/MbQVyn/eDx4dY1hjOX3bOHYeLTMoCsp?=
 =?us-ascii?Q?DhkrlJtw6Bv3fbmddL89V0rkcOL02MvjD/1yocMqoTpPdgji/nDNz9TjCcYZ?=
 =?us-ascii?Q?IDFVM7G3ImftDs9zzff+fcB/m0QQPmwRL5DROyS2YHnLdmQQbHOMKUeGFuL4?=
 =?us-ascii?Q?u7ZMIaxpm6z4giMtVbSpHr3dYwDtXuLsgWgHSFeiMc1YAOEdSO6qRPA4AQNm?=
 =?us-ascii?Q?yUgb3BcUhio0RV300o30Wfp37tEBbO8SwXH545imXiRw+MuY5lbwx9xCOaG+?=
 =?us-ascii?Q?18R816AVYYnJmETslVlUSRkLtT0ioV3Ajya8azj1bRSNdKlifmfCeTtBTR3w?=
 =?us-ascii?Q?hjhEAOZDQXljdK8mCUbtbFvoEHKyGHYoOjd2xmFrjLP4ShpnVi07tkFz/lIo?=
 =?us-ascii?Q?lasuXmBBUkrgcJTi3bercGAH9eCybWLdMk3SvAXthNG2tq7J410TJP4LGiw5?=
 =?us-ascii?Q?auI0xEarP18lwP1KqkIYwJKbyYio5ehVX/1E0fgKAh5fmB0H70A3IDfVzh6T?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434657cb-890e-4de2-0fad-08dc0dbf859c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR17MB5515.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 07:25:41.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv0wK6pEO8api6d5gA2olJtKnhr3afJ3RWhsm3C0NBbZVncnZJ+vsay9vlYmbQtM3Pj7eji2IPLDfptbuH2Boz5gFzVxJP2js8IqkIkeUNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6051

On Fri, Jan 05, 2024 at 02:51:40PM +0800, Huang, Ying wrote:
> >
> > So we're talking ~1MB for 1024 threads with mempolicies to avoid error
> > conditions mid-page-allocation and to reduce the cost associated with
> > applying weighted interleave.
> 
> Think about this again.  Why do we need weights array on stack?  I think
> this is used to keep weights consistent.  If so, we don't need weights
> array on stack.  Just use RCU to access global weights array.
> 

From the bulk allocation code:

__alloc_pages_bulk(gfp, node, NULL, node_pages, NULL, page_array);

This function can block. You cannot block during an RCU read context.

~Gregory

