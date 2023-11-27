Return-Path: <linux-fsdevel+bounces-3956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B607FA5F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A892D281A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7A36AE3;
	Mon, 27 Nov 2023 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="BBykjkBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438211B4;
	Mon, 27 Nov 2023 08:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7quJ0/JhwPoe+pjjBa+dIpSHhAZfAqMR40VItdl9NPp4i/GdC4a4fG/r6qeWApLWnbnfOmHKtW63CZJvLkrfeQjdbm9AYiWNqndySDjXMZBb9cLzBc4Fe6YGsuRNNi5BgYhsf36GaqPYKs68+2sVJwxQFLNk7Evbw5MmrQPW1aYOG9uLa7ZlcIAfhGGE+Un2StoA1mNPSCGTMrDoi4/ZBaPJW1o6O9e7+Q5WXaJur4EgsY+jzDy+r72hbjgG7wGDGPpkqlfPkLtYR2QpdSvLU7uQA2W0RL3NIq7I3AutshSZeYU0R/tBwlbBlA6Xr3GDzpu1pume3mNI74TGsZjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Aw9pyMUxxgXTGggCIAPDiOg8gt/pGqW9ZRsYPBCHs=;
 b=kcmm0DCs4Zex+vMBVnh9RM5nRRmao4GICkhzVtYwCCYuCdsZ9u8e2l8S6mkFpCbaQN9zpQLceZDGCcZwen9KmqkM/JUfKZIHDxFKKRDQoKz5jEyWXvI/qSp7uUTsnfv7DQVDbodrf5BGou7kWbUzvH7ZsCrz2FnLJpJ6/j1rAuZHbDk0jXpDnM5uOkW9ntj0sRt0hanPueuvmrDZMfuQqZImj638qlzASUQ7M+KCGfihtJqZmpYjC3XwzcDRjc2z2b/xA7L/RkimtvUPRSs2NHmwD8CvWgrkB0vhEPX6XgTOpaQcxHzD48+lqgqE34QgtcCLyXjwupgIfjrtQjlBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Aw9pyMUxxgXTGggCIAPDiOg8gt/pGqW9ZRsYPBCHs=;
 b=BBykjkBhmXAEcUZsNoYM+diuwyg0QPKWathNjmg1p8vsYOKpJPVfYpS3sZvu+Xed2eWpbR/W/YFuMh7r7mOsUWb2rp8l9HppRurUFjdimya5LPswf2FeKtnPtj+zLdmNmmiXL/hZBc8mn/ipnNP47frLqZNQ7KR5zhRradSJ6dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4837.namprd17.prod.outlook.com (2603:10b6:a03:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 16:15:00 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 16:15:00 +0000
Date: Mon, 27 Nov 2023 11:14:44 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	tj@kernel.org, ying.huang@intel.com
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-ID: <ZWTAdKnBVO0+5bbR@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
 <ZV5/ilfUoqC2PW0D@memverge.com>
 <ZWS19JFHm_LFSsFd@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWS19JFHm_LFSsFd@tiehlicka>
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5061f7-f429-4a1f-5661-08dbef640102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	co4+9BfenST1vonnfpsWoyrrP3v8a7qTUHqj+gPRE8HpnpUMDV1Ceuh/u47M+Pq3/fYjZiHfOXDiBi1mWy1ktrsyoUrydEyZl+Un36+CYYhC0Lla/nWvnWvMZras3cWtYdq+FTNGvzpcdZRehTEQ44Y5yAFP15EB+AT9mxhJKdP4EjAHM0ZPx72jVIi41l363xj9m/kg6kXNIUdzgj4E35CXJesybRa6Q4Y0GWE/9OhFXzrLYSdF4PFRd6SDuJQculZIeWYzpXuqJ3qnB8k5sTZzcYKWKZ99o8DpYT+31pJTr+YMrP7PnW+3Ntj+6QC+hCBpKiUQQeen2Tb1QZM1PcBfYAswHdGl2ejNgEOiJBKkVAJdIZWrlkIG0MZsJb1WunXx9DCYz2t0JrsdkC8rQTN9zuRKipQQnnVAIDMA4HR4zTkvdkySbIN5Pr6m81qvcSdOkKbzP6Vvn1umnocX6nZLm1oOBZo4lzK0f1GDkc49RkaavyQQTDnRWdY99iSqYf2qs4OrX3jQQN+UybvDyZOA+U9kzKwVRuhl3XQufXh2BmmZq6/UZO33aQxjoqhGegwAu/2GZbIuTInUunH/SsDCHp+So7+SzE6QtJ1RQc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39840400004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(6486002)(2616005)(6506007)(6666004)(478600001)(6512007)(38100700002)(36756003)(86362001)(5660300002)(44832011)(2906002)(7416002)(66946007)(83380400001)(41300700001)(66476007)(54906003)(66556008)(4326008)(8936002)(316002)(6916009)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9gI5u5UaE+LGl1pKWYmuVOx0Ppzy9Kf0xMqJk/wODCjJ25bngK7y4aEx5uWT?=
 =?us-ascii?Q?bsQshGTLqnNVg2UX9Zq95qHvP5aV2aK2YaYsEiRG+5tlEKmeACkf/38wvUt3?=
 =?us-ascii?Q?lTOUl9j1X/TzgO+Rh1s5/NrXyaeLDL+z3JZJiuVl8rpVKaBUl+4vWX03b2Zb?=
 =?us-ascii?Q?btiJDb3V5zWPMsZkjDii7OOSQoSUUMSseaWj4YUuaGTOQer3REQvUrZ+Syaq?=
 =?us-ascii?Q?gQ+36nCKaWLHnnf+WaQvKqswyxxzJUr3w8jmHD5GnULVYGn49NHttYyYxCcD?=
 =?us-ascii?Q?+COLAaV5OaNh14coREDz1MQrhdHcpkw1+FKGM69I7HAy6C29ZnlStO0FvwV5?=
 =?us-ascii?Q?AaH/1azxyEmsvqWnH34h7hhg7THGRVpFcIjq2s2rytLZvsM3Ni34JQO492T2?=
 =?us-ascii?Q?MupfxMTW0ACLZRsB47YMWD+sQkFjlCdE/rac6N4K5TFN6dsp8bdjM6mS/bKW?=
 =?us-ascii?Q?9QBhgnbX+YRyKdurgHipQ3+8LFYwu5WcBLeRvPJfHfiYP6gBrhxJfv2htmEX?=
 =?us-ascii?Q?nz2Ltq+NNHf/8cCYoJPvqkESSZpRk+ZBhIUs1gaHEzQ45NIipbpYcHUPzsG0?=
 =?us-ascii?Q?nTS4z1sy0ZG+adGrdigl3ErbJbV9lfkC8tZI0u7V2FEQLZmM8mz3g+ai5DQO?=
 =?us-ascii?Q?Mai2DlQXO0MW8cT1wx4EiSC42/XH/FE5Hfua7l+X1is/L4GAGbHRh1sXiZhH?=
 =?us-ascii?Q?9nnvdTUkt7sGKPmgi9ma193hZnV2aD+rUhU8idLLpFMn81hvBYpQZXabc3V4?=
 =?us-ascii?Q?P9l2nEr4IMJKb7M6vPAOtcVADNlUFWpeETo/laWtyzoRcUuFSP7Eck4JkTNr?=
 =?us-ascii?Q?zXTBzZeohNW8tGR/kZMcwjk5vdGhsOLhQS2JGOez+41cDNaoKPabnxUhC6uL?=
 =?us-ascii?Q?f9+yuGEmeLEUvcsu2zIIDBkjnLGWRo/t4dLSTyzaFYScOwm3QJiNHAZDD6Fm?=
 =?us-ascii?Q?rG4Uj5QvIuhysekBrUTTh8L9kxxO+0praaj97j1yBKMC/UkjikujTDl1L99R?=
 =?us-ascii?Q?yfG24+O6nMHo9fxnA5ZrprI7CrfA4UbM+/NUPU6pOM4p80dnwtToH1JyJvnZ?=
 =?us-ascii?Q?gs/1uOIWRW74dYX+lQszGG/DHKT64eFjSj7xP6E9eZPLwsUj6FlkjZd2vrTP?=
 =?us-ascii?Q?gnUpZse8uHSonlzmfIYp/IM1TR3M6keTw1joVGjW6WJiDVBDemUkI7luHRmx?=
 =?us-ascii?Q?GlYlR2dgOEKURiKjXKzTrX7IHpzKvsmVe6DOj7mL12t0+S/yflNw2wbe4ayR?=
 =?us-ascii?Q?LxGfq2LJF1KjDhM0hgKhEdOI3BaIA7RamK88qlzdTw70dCOAHd80h+aIB1wQ?=
 =?us-ascii?Q?qfSqvCG+YzgU7r2rZCnlpTV3Qtd/VIkQxnSKg8yzw5TUdmSeZVA4t7bjm0Qw?=
 =?us-ascii?Q?nFUzQtcGNR3lut7WDrS2IRp+5LUWxYcrvX2aUavoj4+PO/Z9bLOqBL4VmOAh?=
 =?us-ascii?Q?4PRGRk/GspeGwvURAPiYrcrW3otGRso7u/5di3ukpM1LPI8+a1oF3/FjabfX?=
 =?us-ascii?Q?BHHYdcE8VE0sVXTHu37OkKao4Wi8zF7h4pGNKi4KPD9bIP70jlvZHpNfGz/a?=
 =?us-ascii?Q?mhjcZAEDG7pUQ4yRk9pCFB3Yx3UyQ4S3oA2MINGPz0vmkT6raTwpxjpbgKO5?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5061f7-f429-4a1f-5661-08dbef640102
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 16:15:00.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChMJJSg0PJsS3DAKA22nMf8nmlg7MiEnWkm4s5pZ7tDEN4wE9yLeB3LUT4u+p9jdv1jtDa3ISpxHUZae18WKSK3By/xgIdtYeIClLTGaaYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4837

On Mon, Nov 27, 2023 at 04:29:56PM +0100, Michal Hocko wrote:
> Sorry, didn't have much time to do a proper review. Couple of points
> here at least.
> 
> > 
> > So... yeah... the is one area I think the community very much needs to
> > comment:  set/get_mempolicy2, many new mempolicy syscalls, procfs? All
> > of the above?
> 
> I think we should actively avoid using proc interface. The most
> reasonable way would be to add get_mempolicy2 interface that would allow
> extensions and then create a pidfd counterpart to allow acting on a
> remote task. The latter would require some changes to make mempolicy
> code less current oriented.

Sounds good, I'll pull my get/set_mempolicy2 RFC on top of this.

Just context: patches 1-6 refactor mempolicy to allow remote task
twiddling (fixing the current-oriented issues), and patch 7 adds the pidfd
interfaces you describe above.


Couple Questions

1) Should we consider simply adding a pidfd arg to set/get_mempolicy2,
   where if (pidfd == 0), then it operates on current, otherwise it
   operates on the target task?  That would mitigate the need for what
   amounts to the exact same interface.

2) Should we combine all the existing operations into set_mempolicy2 and
   add an operation arg.

   set_mempolicy2(pidfd, arg_struct, len)

   struct {
     int pidfd; /* optional */
     int operation; /* describe which op_args to use */
     union {
       struct {
       } set_mempolicy;
       struct {
       } set_vma_home_node;
       struct {
       } mbind;
       ...
     } op_args;
   } args;

   capturing:
     sys_set_mempolicy
     sys_set_mempolicy_home_node
     sys_mbind

   or should we just make a separate interface for mbind/home_node to
   limit complexity of the single syscall?

Personally I like the dispatch for the extensibility nature of the arg
struct, but I can understand wanting to limit complexity of a syscall
interface for a variety of reasons.

~Gregory

