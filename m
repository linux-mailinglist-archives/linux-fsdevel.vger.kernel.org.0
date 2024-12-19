Return-Path: <linux-fsdevel+bounces-37799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9E39F7CFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530D21886267
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBAE1FCCF3;
	Thu, 19 Dec 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SnCwCuqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF069D2B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617965; cv=fail; b=jfKpmQdrpPuQ7xWR6Z9/WkeZvMusyj1vUakJ5ugAPTOAn5xybW/Pjhj9wd7+ivZC7GD/UKcbuJzD4zbROITciRi0ugwiMub8QUD3103Mc8eC4mZbbcTdPtyz6ehO+TmZdwHJ4+Tk2YitlW0bPogVvSvPsnE3vEJ/vxouC0ENX2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617965; c=relaxed/simple;
	bh=X16ZSf9KNARxLuy2oiFdCbTh/XI7kFwIBwFAXHsgef0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WY47abrFrULircxMaoCNIRRzKIcKlINdeaGfLroxy+kDpaqo8el1liQkZmmW9RevchBdnPaWx6b/T30RcdL4wQrFQ//hx3byIKQqXs2Cjyyc22ss7TOvC4yyJ/S6/E8sLxHUndR4kBR+ldwDt3W1JJCjxT2r5a593NaU1gUTsGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SnCwCuqi; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC5rbHN2q1R6NvYVxwyxvS4bkwpRZSbTBPhXEIyHaajCTSGNyL5yxWs7x/iOoUExVQBHNF7WycJWfZdoAjx/vpiCb/K/oGOYcR7WGfVMnRggN+crFakc99Tha9FxF2dBk3/Vyj+CyBuWrTvJG05y2j98kGMFUY3f5A3AGRZLgom3ML63n8CD4ErlRGX9G+XNtvjdUdBlYCu7hzNMsJdjgNtV9gdC6MXokDXKQQ9wM2BoxxtplVQ2ASNBoSpnOvOgoErc7ypR2mmvaNN4t5ynpJedA+RcEd5RNcMP6nDUzC/sx1j1Q7rVXozOVcwhYPRE2F4QKsoEa/kVD193NjkHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvV/enoEoeXhEgv8q5+oEQo9mVrYUVvjyfOM6fvq1Pw=;
 b=ERROPVgiOJuC50Lj18JJiML4mpPKYTfHMVmGIL5TZNL0rfkvVPhWKkosk0fGaLEbzaFVzFfOXyqdu4q7VXFje2EXsA98/fsXU079ADnhEhkaSUDU80dYgvYvsp9/y5s4+2nR4mrvZyLUAzxSFrdnjZyRxqFrG87rlCN6bvjolquh3100KYdq32/9rKEH1KJrfXfb1ceF8M1iY3WO9ZKmQIVtYwhpty+gKzcBS0Wjjyx+d7qh7ggm4CwkCt+u95+eDBMHvNvBYhlDRm8EgURxC0Ry1YyPpe/2haKa/QNx26BlJAkKodu3d5plabTB5HmP7qwlsyTsmmI3xFWKNBQs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvV/enoEoeXhEgv8q5+oEQo9mVrYUVvjyfOM6fvq1Pw=;
 b=SnCwCuqilkp6ldL3/5alMFcqGHX2VRYYyBUESbZkWmW4T77XrlL563sfxeYWod03xOV/EREYG/DkOPIMnLNITfrXKWO+IHrJXg07HuxsOa2b9bppLQxt5pZCmsePzfVU+O+q6XlT08HdkdrbPDoQ0hwzg4rYu40Q/x5xHKnJfvSPqq58C7o6hdJdvRzdZ5nG5sYrHDbmwnhyUHscvxCLfq4Mfq3g55CAq37AErkwvM1Yy1EuqZSq8gSgV4Gz3rC+KBTnmaItPowfayAH9y7axsjAHpoPR7JdtPwq0V6MzhyZ90csEj3GW5PgPFjTtyueALzCp7vvQi5lpkRS5kETrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 14:19:20 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 14:19:20 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm,
 linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Date: Thu, 19 Dec 2024 09:19:19 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <485BC133-98F3-4E57-B459-A5C424428C0F@nvidia.com>
In-Reply-To: <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:207:3d::17) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba49421-b04a-453f-e371-08dd2038212b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8XaKya+Y1RCkHN/YV26wOKQgdBYgFgna76LV4/PG1JHb+j6r6ddS1slXPUFG?=
 =?us-ascii?Q?ZIYFOPs/H51gYvJFX+0ycIg5SrWrjoWuDXkRDFoWpqK/hvhTK98+pSu0XYqZ?=
 =?us-ascii?Q?GOPbBOu0SgETKpWpO3zJcrsnv9nkdHcK6SvmkC0/YNA1kIszQr1FlKvles5d?=
 =?us-ascii?Q?lwiGZsDS2oMPg0OA4AX5S6a+qjxgU1llDCjNabOeIdJp2U2eHYO/sfcG+h5P?=
 =?us-ascii?Q?GH3b9uD7M0dUGC5NbEYQhRUjP1d44eWRlbACRXuGiWVu7y0J5BaYo7TO2B+K?=
 =?us-ascii?Q?h92M2qKPpSWWbIy8/t/KOVETZQgBnr6YN/Kkzm+KOGfVIwTejApBBPlKNYr4?=
 =?us-ascii?Q?7hJU36famGhTBUMfI6oZ1RGiCA8AFgdrc4oxNMYIJtq3CVMU6vVxuYE0tv2a?=
 =?us-ascii?Q?nVZRsImJ82TZUuwPToF9EikMpXqkxgsBU/cVbQ3FlxIetz4oPv0Ikvx4aMOK?=
 =?us-ascii?Q?oMKVDOS1EPIioSZ+S+Wb09hDKy62gqTH+82ftE6JCI3y8FY6nOVItQ5Yo3m9?=
 =?us-ascii?Q?jYSz73zPc8iE6IMmd55f3s6kdoNtRs2f5ZXPLaVOM1joNUabiSmgYC8ealUN?=
 =?us-ascii?Q?XW+cq1SUgts2k8cDTlXRIeLZixomrURQsd0ho7NJY8OieBpJV/OAaZS4j9s/?=
 =?us-ascii?Q?S+Je/RmcMz31bE/Mn7N6haXTFSgmXVmS5aopRP3S4KGufJOyvWakKPD36Blr?=
 =?us-ascii?Q?JsCN0lpxzDSmI+b2gvdTd4pwiMA/taIAU/k+DBE0d+iClQYAmpi1iIAm1Uni?=
 =?us-ascii?Q?+nQNcrgXMImu5FmbnoThYKmN4S5byFcUeiF+HTRALEDJ4EZ2qQH/a2XxRuG2?=
 =?us-ascii?Q?1rGXDE0ksgebcIxUUETy1K1qzr6y0+mBdTAEsVHqcjL9ulWH88jI4G682Ziw?=
 =?us-ascii?Q?J6dteRUJmF0XJwghRz5lvR3MVCc86eeUNz8wwxcQMzMStS1EETmwc0JIw2uJ?=
 =?us-ascii?Q?na/MaMoUFBfRM14gLLB/QyLJQfcevp5W4GnBv6/Qli3hptyfIkPPGg4qQ75H?=
 =?us-ascii?Q?tJm/Be0nvH7ir+8ft+ZncOSwFcC3C4JXvmr8JdcvjMzczkZh/NAYOZZGlxgk?=
 =?us-ascii?Q?dUZ1xu8MrLOaRibq1F1Rn6yQU7MWXBo8O4avlHzy58iEdz9fVfILj0V63KWj?=
 =?us-ascii?Q?N7VRbsn8hKgiuKLUedt6zH0UbEIGPBzyrxF+REdEMWk7Q/of3TaHA40XKAOl?=
 =?us-ascii?Q?ecoY5ttTGtGvVKuEBxiVMiUnMBcxtMpjkb4vBssWGHTuuiWZ2PEYO9sMf4fc?=
 =?us-ascii?Q?rrvQbUtMAB437Phm95LrLtKz3AkzJ+eQOyEjU91L78mLP9T2EAeN7ebMxZKr?=
 =?us-ascii?Q?Yu0vXQMF1wVvVbipi0vF5iNAbhpytQgljiW86enXQm0SHhQx1cmV6I9AGAUo?=
 =?us-ascii?Q?QFK8UrIHtP8YTPgIRF02JnABzhTE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UeRbKubqc5ezr+og8bGn4wzXyTlAaJtrbO4VPK1gTAfVD9/DXoSZphgBuyrm?=
 =?us-ascii?Q?appMhTl8Pizt/G5VzM+CDYX7KGBGBUUSmNDEAa1AKsvr3uDmcvk1a++0wgYw?=
 =?us-ascii?Q?fewMqYAYDc+8tJlvqlqTLeVdmrSUTWha8XDMcYk6j+nDY8gBTplmLFDYO5CO?=
 =?us-ascii?Q?TmH+wcSEeu/L37nWv05T3S4eS0zDo3InD/PPFcAcbzUPNz7q3EJ73fQN+Hum?=
 =?us-ascii?Q?78coPpJLFLLGmnWBwH6xTa/E9YNa+XhcuST7AUOxxSdHYbrEWR2ZWfhJGcWr?=
 =?us-ascii?Q?QiXHWjDZ8/kaNqtTc3x0TQ0qn+v/TOCFfSID+oStpQhi/K4oNowFiMFwfVU8?=
 =?us-ascii?Q?8R3WbDZML+3B+Q1HtQ+h/soLIKDTCmLU4GfXpnhc8HXfWmkIMCM7NXmDDHoz?=
 =?us-ascii?Q?WZfwCexzjE4mlrfwTSMxui0n4h0tC3QqsMJk4TTMM98F9etD51Zl/Gk2ka81?=
 =?us-ascii?Q?S5IscaCGNnSwOwrVjOXT/bN6omRmRCUCbl76GIUFwZG+JC7MEc2tN37OvmwR?=
 =?us-ascii?Q?uc9S7qQYAmbnxQS36+pf+X0qtepA5h1ceCqfrKL3lUf8kUC47kcoQFcMgLc0?=
 =?us-ascii?Q?AB+uUItYwH0pZL2zvVP3so3h4MucLWId5jqAWtjRVQNTV5IXxmL0l8s2rBaY?=
 =?us-ascii?Q?XWQ1b617DCM7yz+ZiwBV2NZR4b032rvLhhemavkmb7dIHU8GKZYOv5j7IFhc?=
 =?us-ascii?Q?rrPxsImmOTqxAFdQksUhtcKiDP/KTCqcuV74oJbHVg2cAupUE+qj5skbo6AH?=
 =?us-ascii?Q?k9QORmAX3Cy+lXMhPY1wuD7C9s4vMZIWwYggvH9Qx4BcJ1AZcby25uwwzpyI?=
 =?us-ascii?Q?uAp9cYRacMUAh5fSyEsilSTbR9NqfW4YkO/RKYWfasmo091y0JN3+UumQjw5?=
 =?us-ascii?Q?lxDJDR5ksdT3WuQ/QT0xalVEiXXnmbo3gXModt83E5rDqp/Ui+rpDJsOKvAC?=
 =?us-ascii?Q?QtJkvRalyHzDu++vzpJxufjp5ptRYongnIDgcLUtNmZHk81GPU3PDoxzB+zU?=
 =?us-ascii?Q?ldFOriGdxpujyf2LfkIeSMzTqTmqnWxINZ0jPQKDKCTR6ic4nnKcGSYyF37e?=
 =?us-ascii?Q?6egNjeS4i/6nZods5h91LTGiB7vGG0b1KATfud5FE8UWEmQuoSiIckW+0dGD?=
 =?us-ascii?Q?DUKVO2yFtAQ5B4eY34w9dP4zBlwnbXYLUEgajUFKkqhMOWtgQOU1Onn6ON8A?=
 =?us-ascii?Q?mQBaZWpnfjd03JzNUkyiWzBwDTIijOPYisBCJPXJB8hH5rnnXtX5+GIOXPIc?=
 =?us-ascii?Q?//joVo21Dhuz6/paNcKdD4G/MqDp5pAD04b9eRJpRMa3542RAnOGnCpst/4x?=
 =?us-ascii?Q?6Kk7ZqBrqbx39Lxnxn5N5MA5wvUyhhz/bzyVf+Gm1XvCmuHeekwC3h+GxtXq?=
 =?us-ascii?Q?XX/W0T6cLVIDHhdTGWNgEpuz8eaiShZO4/1CJ9WHue5FfEptHN0V4p3GnfzT?=
 =?us-ascii?Q?YT/eHoCtETWls71vf/7icgy/D95IjuFs7ydmBoPmYrpwTx8omCaGS93/yd7p?=
 =?us-ascii?Q?gTcOiTrxhYIb7Pz8LTvUQ4lLqOqFdO/D6X9LEJYzkCITOH2vFFPPZZDqgRTs?=
 =?us-ascii?Q?ddVUgleQBee0biqFtMA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba49421-b04a-453f-e371-08dd2038212b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 14:19:20.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVTSv0bh660Zrq/PGo1abObAsZyyjel8aurdTiaSU4v9vnhnZ8hw4aGW4FAazOBz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161

On 19 Dec 2024, at 8:05, David Hildenbrand wrote:

> On 23.11.24 00:23, Joanne Koong wrote:
>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio i=
f
>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set =
on its
>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping,=
 the
>> writeback may take an indeterminate amount of time to complete, and
>> waits may get stuck.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>> ---
>>   mm/migrate.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index df91248755e4..fe73284e5246 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_=
new_folio,
>>   		 */
>>   		switch (mode) {
>>   		case MIGRATE_SYNC:
>> -			break;
>> +			if (!src->mapping ||
>> +			    !mapping_writeback_indeterminate(src->mapping))
>> +				break;
>> +			fallthrough;
>>   		default:
>>   			rc =3D -EBUSY;
>>   			goto out;
>
> Ehm, doesn't this mean that any fuse user can essentially completely bl=
ock CMA allocations, memory compaction, memory hotunplug, memory poisonin=
g... ?!
>
> That sounds very bad.

Yeah, these writeback folios become unmovable. It makes memory fragmentat=
ion
unrecoverable. I do not know why AS_WRITEBACK_INDETERMINATE is allowed, s=
ince
it is essentially a forever pin to writeback folios. Why not introduce a
retry and timeout mechanism instead of waiting for the writeback forever?=


--
Best Regards,
Yan, Zi

