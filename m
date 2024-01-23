Return-Path: <linux-fsdevel+bounces-8507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918A8386A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 06:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3541F236A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 05:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA674414;
	Tue, 23 Jan 2024 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="AlHUIA/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131483C29;
	Tue, 23 Jan 2024 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986981; cv=fail; b=ZBgZWMY7mXVOLQ0fk0UPzKvA89x1I2f/1V/qBZXrtYDd+8i5mq1g4duiR3wcTbE4QHSuXclq15TUlsl0bn5TZIjD5aBmLPUkTgMJ0f3taTtWgspdoHplCYyv1U0fm2zLOQhcz80r+wNyf+Ij6ogrRXiaymj8OTo/IN/gOIYTBws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986981; c=relaxed/simple;
	bh=a/55D2DfrAeK8nc3LCSlgXEgL6vjBNMGH4W1+AWQX9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQFL0ubo0FJ8ClyyzKBef3GeHjMHXJ9F7+s54rBJecO8BjEi22b8sIb/EBak2l42AO6CpnC4MDodDSkez43v5C+oJhPc4VD2YiaNKMuj+al7Jptkx9auuF5mzSE+i6AJYX6ZcwQi77X4/JA/7Usd4VS9nGXiDhL16086dMFn51A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=AlHUIA/E; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo/xkBcTLzivETkO9ylVHHUS+QtMd5ALz1NgVtLOZtVb2Pk211NMiyA00ixTrWv0DAcqkeHiFDmy9AoU4TXIbu24OQ/Ndg2WN0fJN5TTUiOHyEPId81gBy5Mj4MpBr4nDuzyco+FlGjPLrVPkx+yl5VG4i9pu8JGYjWT1PuoCRzbUV7mCF2XL1YMCnz5384YtoKinrpYFh7TYKu6BIofQsUaWM+eNLBWMwVevVrthpNc/o6GboGyJ6eTHCtQthO1Nj4qVBErweUlaP3XHahazIPcwPZU9CRx8uU1yJgBV+zdBOSUNJO/QGnJKnYZ+Rxm/bWhYIdfw+06VtpzeOul2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XewSyly/7oNkEaqy38F5YdNGXjcQZspue3Z5A1Rww5o=;
 b=Q/ubuOnmQZ//gu9rla5mssSVAu1LiqTC18LZkzUDS16p83nm30RC/MLXcbLr4D9RLpOlcCXH5fgMgvA2MnCknpNd8d7JZcjvKXefkUX5oD8zEGXzgy4iiAlemYNjjJIJoNy9l1EUbxBSKDpHAdWjYJJOQZxS0EVREwlCzq/L+j4qIlaG92gFSIWNe42XWaZ2hAXg/inWik4Jqd11nWsR26dCxIqCCQXz+w8sl22PhoklohETseRv2DWxZuG5Y8RasQXpdhmTtr6vGQvplarDxW9agh05H1uCbpUZFeOsTLI2wwpFc20St07S/IqokYRWcb3As2BBZlA1RJGxYgVFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XewSyly/7oNkEaqy38F5YdNGXjcQZspue3Z5A1Rww5o=;
 b=AlHUIA/EOkazohkyr1IYcLGXcAuCQ254aVejUXCA/3yRYHh2f7vYN7GmbYvFRzmDdGUWb5H21eXLsVu5j9zSnRh/+Ws5NPrxa36fJDz0MZLTntJEwb659jNpweCT1GE0aoY9PAj4SivVO6iCI9oFNpZMJ/LI3F4/NMkp+sioisc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA0PR17MB6226.namprd17.prod.outlook.com (2603:10b6:208:442::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Tue, 23 Jan
 2024 05:16:17 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 05:16:17 +0000
Date: Tue, 23 Jan 2024 00:16:12 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	corbet@lwn.net, akpm@linux-foundation.org, honggyu.kim@sk.com,
	rakie.kim@sk.com, hyeongtak.ji@sk.com, mhocko@kernel.org,
	vtavarespetr@micron.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	hannes@cmpxchg.org, dan.j.williams@intel.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v2 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
Message-ID: <Za9LnN59SBWwdFdW@memverge.com>
References: <20240119175730.15484-1-gregory.price@memverge.com>
 <20240119175730.15484-4-gregory.price@memverge.com>
 <87jzo0vjkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Za9GiqsZtcfKXc5m@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za9GiqsZtcfKXc5m@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA0PR17MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: df24a963-803b-4940-ef30-08dc1bd26d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V/VhvUMlOhEpeb+IhXhVo01gshTnU3Iv8PYXQSOBWh/Db9xWmftOKddDDu4zg2OPjbpCHLfYAr2yH+UdYJO+crlV+JXw3WrGJbDqe3WmdHD81x5dxSAFEImZ65dKjR5cu8FMkpuKcjJL5OBQc8mXG0sAypKc/pzD9qooJSOGmw2v604IIW3IGmw6KKYuostggMlAq5aRYtA0ub9ZNJNw75JNzKnyzIdySMwB2ibRBNuT6j6MZDqt3Tfr70qMpx3F/0nS8GrBOWQXxN2QP1W9F3l7LJaVLF5pYHkejb/ha95OCCKD0JEwsL01kFO/aomnipDrl4XUN58u52CzqUXKSOByFMcnoSv0cXqQvmWE388AY6AtL1II1K2DvQ+7Qf0J3mjR++Iho++9uDPimr6VZjusHBix+agrTuEOuWiCJ5rd1YFmHmC4t1XcFVsI8hzuMA8NDmB88Kpl7y9MFCBc29+TmPhpJ9F7pt/jl4beRQGEnUZdJIazSFOsM8cx28NbY2mg6USD3GGXaUX/e8G8Feg0tHpMGjNd+wV0Cp3diWKlj/ImbTk4SJ8iBrIHw1j7y1tYHLmMZjjejGQUySbKpmgNWWymZTfAbYj61fVDsTMDMwR9fO95a3UkirnJPCdO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(6512007)(26005)(6666004)(36756003)(86362001)(38100700002)(41300700001)(44832011)(66946007)(7416002)(4744005)(478600001)(2906002)(5660300002)(4326008)(8676002)(8936002)(66476007)(66556008)(316002)(54906003)(6486002)(6916009)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KHKVFFDyJbb6+pvI9eFi4PJGyzeRG7+KSn4aTelInOP/MEbF3Wj+bZesF5HT?=
 =?us-ascii?Q?u8Q1qniUAkWwhS2SBW6t7Hk6NFjnTzApMXNrxS1p/+nCNiL1lZqge/VhFW6D?=
 =?us-ascii?Q?Gy6vb0ZzW2dYKSaX2ZCOjYgfJTThKbDAjwPQ6tnhMIt5FsepomnzjmvdnX86?=
 =?us-ascii?Q?Cy06L/Rxtqvc3Vnv7mit7/0s/E7ffX6m0D7/82BIb0dlDznmAEF0ClSXNhjG?=
 =?us-ascii?Q?Z65vEpMLH/ox9eIONjOrOHlM63FBln85f2ZxYV6FCAkjndYeI8ZYP7qZBF0b?=
 =?us-ascii?Q?ZJV3bVzIBxYryaQv+SkUMEgYCIN0AAhH8t3jHfH3auDLt+UeNYmXLs1OAXWB?=
 =?us-ascii?Q?3mIYqpdqGttli1eAkO9ZdXXfJlPjNVkctusOkInlh5mTBhSxvwg/fAX34zp4?=
 =?us-ascii?Q?Y6M2tF9CjqUzGFFaL1bLZl1e04Zs2u+W58Jo/g3NE46QQRgRnwnBnKi4HBQI?=
 =?us-ascii?Q?teBT/K6FAXxi/8wfNoa25RvM2WThbG6mxqeVgtGx1Hcl8Tx5etwGgQlRh+tx?=
 =?us-ascii?Q?Mn/GCpvfeHrMn36AK31eqIVusdAa/TzPQ3WdjEBqG1DFiWEIMQsh/oCHh79h?=
 =?us-ascii?Q?DKPPTj9QSmWTLH5uL6IocDOeDzuWV0YYCOYDMl9XMv4q0pqW7Gs9ddW5uGi2?=
 =?us-ascii?Q?rzVPWW9IA0L0bPZqi6sbDPAGlk02BwkHyd20G5jIdRGw3QXokUUi3/HpPT5V?=
 =?us-ascii?Q?dr/M2AAmLGa4NLhw6S/NEJnHtNXrlH195BTQ89nRUN58besEyCIqcoEOmJCL?=
 =?us-ascii?Q?NG6YT24hgdh4jB6HkA1mHcEKnCgIeRFJ9cz3OlXxb44jbS5acszbib6wP6rI?=
 =?us-ascii?Q?RQlDpZon0TT7vDIKDJci/7Dk4uEX/Hp3sTDfzdZD2Q8JAIVLoFo+UJX1CnQg?=
 =?us-ascii?Q?wp+PZVYSVQeKLo9sJ1WjX3bNf98Lllpa0AxxQEuuYrv7kIA+0B+NQrolKiMx?=
 =?us-ascii?Q?oR4jc+SOFpWWwBZjT/3i8XZNe3tOD4UB2Eco+7eOSSEoOmEDGL0O6Y+NTXzt?=
 =?us-ascii?Q?7T+besmi6XKxcmhjm+FTtVWlSfVoW2jXz6z+gA1v2+15RA/G3AjWU2ESCvzh?=
 =?us-ascii?Q?kKPeijP5DABa7j6mbdjCJ5VRQ9VyI+Ij81yZH83BkFYogdhzcpgJP2c6vdgX?=
 =?us-ascii?Q?nAdzmFwLNxEbGGUY6p127ZL83vi3X59NTHCHYQeZN85jT+e3xh2GoEAsx8GU?=
 =?us-ascii?Q?1uzYKYpImw4qFPIB60u3F+YYEjZKp7qgD0KGW9A+BSCA5J0GwPmHB8Iwhdvh?=
 =?us-ascii?Q?MA+qYEnIgfMMGx/tcHUtzM2OCxGC2xXF3X/B3/gxZmt2tMo3pMMuXJvZylrX?=
 =?us-ascii?Q?UuZ6nlMiZt5ZMa2e9EtF7f1l6AJrzaqRqNC19UtkAKywwh2k6rS/V/a9eMaR?=
 =?us-ascii?Q?pN2uwhfXYcR4z7gQl9/hpt1Va9YiQlJVSmHlbHs60cfzWHQ8ki9+JpXb1fyw?=
 =?us-ascii?Q?8Cj5ueTI2/9LLVlzyTVkLcu5wBfvgWW4fvT2nfcY/iiiY/pSzo8QA/TvCRRQ?=
 =?us-ascii?Q?C2Iusgae3YzzbsoPJk+qQl38p2GBFLsPpwypsLpCcZUascXR7tx/lJap+wyB?=
 =?us-ascii?Q?gIybh4cohmilWe51VoNuMVqh6SK1r19wYXx9koMh2UgYXvvJpQMXNoDHY3qy?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df24a963-803b-4940-ef30-08dc1bd26d21
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 05:16:16.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq37wzpdHGiXps6J4VbczIpQcMrvDndpSquWicbgd+nOB4HX7lkXfJg27S7AAkQCX0s78df+CUgMBi3onFjl0S7rXpUv//bX8VLPxR4ugCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR17MB6226

On Mon, Jan 22, 2024 at 11:54:34PM -0500, Gregory Price wrote:
> > 
> > Can the above code be simplified as something like below?
> > 
> >         resume_node = prev_node;
---         resume_weight = 0;
+++         resume_weight = weights[node];
> >         for (...) {
> >                 ...
> >         }
> > 
> 
> I'll take another look at it, but this logic is annoying because of the
> corner case:  me->il_prev can be NUMA_NO_NODE or an actual numa node.
> 

After a quick look, as long as no one objects to (me->il_prev) remaining
NUMA_NO_NODE while having a weight assigned to pol->wil.cur_weight, then
this looks like it can be simplified as above.

I don't think it's harmful, but i'll have to take a quick look at what
happens on rebind to make sure we don't have a stale weight.

~Gregory

