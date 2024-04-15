Return-Path: <linux-fsdevel+bounces-16908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E38A4A9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 10:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DE2281237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1239856;
	Mon, 15 Apr 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NG20jgpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880D47F50;
	Mon, 15 Apr 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170538; cv=fail; b=RZHAqyj68T/UvKlLkk4zwjxFgoucbIpgJrx4yK/w+Lr9LcWsAvnqHyNlGUStW2Id09ky53qvMa2hgGRNuV1NfzVKQREPsTCi2mdegwCBZB/wW7P50I8fTL96jdLmrYCqwtRWmoBTg0iVogmernrmJ+GMjelOMt41A/lBdY2D7Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170538; c=relaxed/simple;
	bh=/L8L0yB024+8lA+0V6fgP23DqNw/ea5kI1BlqwVTWfI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=g9xlZWtFifkeIHW/dQTkQkPmLAVngzSNJlKKIwn7YNRb4o6n3VfG1XD+bE2QFA7ju9Zyeq+jfw9gfZlbtdrlKnIMxCTBQ1QzlWxTEzpwDdM1sCc+TEsxTSXdxyj417mnFJx9qvj04wtutHHLf5cL/htKGIMdNezNkAOzjvHJE2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NG20jgpE; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4Ki3Ec4Bfuj7Su56DyFxzVTLQ8UQ9gkkN/XQnUtvwGyBFGAgFRazZPQEgLoS+tlKlQI4AHECWNZg77k6nGV9zdSPRDYRfVfp1wZPbZOvYmVWrWojKL2yhxKnEMUp7qN7jhH3s5pr+Pco9Qp04/6rXobM/J0s8hnTqFKkJkbSx8bRPMeCSJsK0FY8ZqfGcN+Wiqy+XJUc4pSdsHn6mkZq1+eIm36/afgTERSsAXWd5z6m/a00k+Ge3xTURaWe+GRvqIS8UrfIq2Xbqp5R3CbFripzY0LCPTEulRkf1I6rgOXaer9btnYAQMtV1Sn+SUMaE7+AOWrdGBDDogTtXuxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaMjCNUSAnRHUMePnt6t1aTqESRCYkjmKp2qH1yf244=;
 b=YK2azDvn8LCH7Zr36JL6FkZU9kd4f434TJGfAQGHeNjXxkpJRTRs9MRVtXCC/JqLfT1ZiKwOzrqhuuGfWRBSeKbmFCpt366odtAzLP4KKKAiI9OdnhccYY5APjLpFzt2QeSw390xqt4VrwGRiil6ka/HlAyE5Kh+AJeROeBFeBtyPbh6372yRBN6qedlegF1I8dXoyngHE57qnPRv7KV9mjGS2AAB9m8iqzl0VYNGMb/MV06ybtGA4ZlBd02I58tFtFVbx+ksvLY65qZ/MrLalsG/TPi0V302Ewv+TH6BqKzwx6LolbAnc8qgbBQxWbug6eY9A+1UVC840UCDp927w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaMjCNUSAnRHUMePnt6t1aTqESRCYkjmKp2qH1yf244=;
 b=NG20jgpEG2xEPO9QleeRLtwzS5pfICYS1/XB1++unPkwLaU4gFjBtDN8soShTN05M9bS1F1MFsBHsF9Z6FUJerCDEwNSalEYbuazkyff9j3te6Xs0vPaX18Bj4qO5mQ0zZEEhJjmaxrqQ/alop9IRSXn/kzNvPMZKYHdVbiT5JDUMv/HyqCos772WAqAR/n675pWIO3F0DIPkoOpr9qAOSwGMtUGVmoxJU7u9L7FxXF3nWgJmiZRSZRZMAjOu28AMQAbF4U0tpitT972TV+SdGvs2cMLBfOwaoo/aFKU1XUhvBk6PeUlmSDol7Yy/qzqpX8JQxWPbaJYtATOKYrAqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.49; Mon, 15 Apr 2024 08:42:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309%7]) with mapi id 15.20.7409.055; Mon, 15 Apr 2024
 08:42:11 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <db13f495fc0addcff12b6b065b7a6b25f09c4be7.1712796818.git-series.apopple@nvidia.com>
 <748fb175-3c5b-4571-9278-1580747a746a@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
 rcampbell@nvidia.com, willy@infradead.org, jgg@nvidia.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
 hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 05/10] fs/dax: Refactor wait for dax idle page
Date: Mon, 15 Apr 2024 18:41:51 +1000
In-reply-to: <748fb175-3c5b-4571-9278-1580747a746a@nvidia.com>
Message-ID: <874jc32f1e.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0183.ausprd01.prod.outlook.com
 (2603:10c6:10:52::27) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 713834f8-db47-4c5d-1391-08dc5d27f17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fA6kpRD+gJThCUREOdD+zlVpVCG1pW33TBGVwHHoey+HPG7H2ZQDyTpQxKk6pVgnRSwVxQtKw8CpCyQdye/i5Z2Lmwx7L12pmyS8JWVwMG+VZk160I6n66xVhEeZaoG4HRQ+ktuwLPIl3qWfrJvymjZ7pnL+v02S5iq8efgZadBknZ+k3kQYX7092S9SsF31foy4+exRoK3H8naxuuKP/5hH4x2Cq1Nj/P/xDBqQxJELazKzQ85H8uZ9DGCppT0kLK6hnFL3YTWRYwMZNhQKWYJY1hoI2LOcQ+jn4V8twT+DB6w6XoutC+5q5830H/DgCqxQ9fRPAQIklpHHmzyYhV7Hd70FVyb/1zKbu9WD1y8/Evk2AQIQBtHaoeyQaS5z83uaUBwsUNlMJjICgPgeQJZ3MNfrShDhlYCml2+/+0yRPIdpKTI465e7zTLNtiQvx9fojYuiqvNu+bUZXFzOFWukn4BWuh9bfLpMhMwqURjUza0BSClJ8JIt+Qa9xIxkHcCUPrk1g3IP1OR7xel0w/6lLNOHVAQgr1m2rUc8tlp3jFxb46alXzviPfhaLTtvphVYClePWhq3Ktk1uU25RvwbWlcuLHq3fWeADc3GfRP9Ly2h0rMqOheNK5zZ0ZqBp349Hbqqw4PDxKpZ398B4ubLWuBDphkKmfzACyp6cME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HknGAqPWFN87TD8HJvvpuKbwuoXJ9T4zFhB3nDzJEsKGnI7R7IMDWj8fkG4V?=
 =?us-ascii?Q?ziuCjBSb9Mp1Ip2TFUButN2qppDCQsC6sZWd8/IzMqEPXU99MQFgTu8KK3+z?=
 =?us-ascii?Q?VknbdqHaEGvBm/VOeqnP72FXCTM0sG1gsYc5tG0h2tg45XGswteHman2lGAY?=
 =?us-ascii?Q?zCmHBA3JQJcEaernydaURX3uhaUKVFb4x8JQSPnfcBQphVTmwXpChA1/JsQb?=
 =?us-ascii?Q?dTa6+y06lNwE1Rf+UeWVejb1qyPMHJGK6Jrn7EAYud5oioFGLUHDqEpTsXe2?=
 =?us-ascii?Q?eS4cheaJZHjPvuZadov4Z00ftFioaIUn4K6cQJuiw6GHNmuaqTnSF28b7diR?=
 =?us-ascii?Q?zKgz8qQ/Xjw/Tv3gzWlNliuIo2vwCotLbaSIB1vNkQAEyZ/M+f2q10mJZs7p?=
 =?us-ascii?Q?nupfPnRHZrZGpItf0FAWLhVJ5L2mxf+aQmoiN4waGuKkAlHVzhnqDVgrWfMx?=
 =?us-ascii?Q?/+3LNoqXeyIl5/vC6UsyE2gupSsCT44Sk86q16RKtezy/jUvS/yIRpylU47H?=
 =?us-ascii?Q?q4fgaYQlW88da9OgDFnDDhg6oSPl1Lxj9fpcNg+4DDOXOASj/YMBe+3t61jM?=
 =?us-ascii?Q?RcGglEAtVqsaYtwg4D36BZTRIY7JRu8emObXr6U6YPSSxNliLq/EW+92kmqc?=
 =?us-ascii?Q?CFVVniOXpnDulq4YuTAwh99Rw8ArBtkSVSfKGVLhvrM7CzN/Goq4CjtcQcvd?=
 =?us-ascii?Q?VA1OffOehGJ9FrwfZSmsEiQpyhYPrH/I99q+r6Uxeb9uXLWRUgCZfoe2ASyy?=
 =?us-ascii?Q?Mf/rqYI42YyoAnSSYjfneFM94GN9uRIHGUDoGITOA7rSQ0eD2LcbeiO5sGSr?=
 =?us-ascii?Q?BeH7ISM0s8KQTiveRwidgrqUUTUz+MDbJQMxQle/AFh+LItTKg27lt9ArkpD?=
 =?us-ascii?Q?BIWhTm+Xpy6+b1eZ3KKDI+ysQWNagCjoSHgF+xOg1S+B2a7Nb5ZEAl3zfiIy?=
 =?us-ascii?Q?2myeScBIWfuWrq7wfZTY9wQXe3QKktJa+XxNDYNkUiTcsyjp+dhYuE9R1xlU?=
 =?us-ascii?Q?n660YHPWGViX1BsMroFeclrhHw1418tLX5sAkyOm6DEW1BA4eU1YDJeFWH5J?=
 =?us-ascii?Q?eZeYjFVM9q8Oq6UUWdPr4BTMWkcyEqtG47e47QULsDjVfv7HlG0vNi2MSlVR?=
 =?us-ascii?Q?5q1GY0DpzaZxx7ytTdpZvgI6xu6vcbV7MkOSzchzYBsM5lChRaoZXqHOhBeN?=
 =?us-ascii?Q?Q+sl+xiFoMXkWam5Tlz0yUJWnpXqk+C45IivO5j6De7f4ClygJUmJorcfsyY?=
 =?us-ascii?Q?KRZo+BaOeDGa2vwWkdyqCAGKIIuHXU1b5eUlvb4T5WhTeDBomF1ECSiIQmyz?=
 =?us-ascii?Q?BPpqxIbdDHzh9FTKeJuXNuHY/ufh0ojfbGWHgjY2/1O1xU+CrDyjbTB+/af2?=
 =?us-ascii?Q?LI5WOTw52bvdtFSEPgRUZ0IRxAAfCbPTTt6JstcM204FndNXWkAuPNHS17wt?=
 =?us-ascii?Q?6jromjAVZa1jbIaqWnpYjbpbrW4pYgoVvY3s5KhouggHOrZAuojOCIZ1aGs3?=
 =?us-ascii?Q?prLDgiAM9St/6YmVF+lFsBIQMwdIL9T5YjGO24FqUhLL/5jfNog8iRmLcjVj?=
 =?us-ascii?Q?ab0pf7sn74xiaMXspoG5Kgx1SxpgI+lh5CUPbfn3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713834f8-db47-4c5d-1391-08dc5d27f17b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:42:11.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzuc2l8rRaqZ1iw91F8W8nyzrwO7GOwJhzL3aT7WmEXgwtiIs3NH2TxSMKnvgfrTY+3h14Ma5Q8ekW+BJD+7ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290


John Hubbard <jhubbard@nvidia.com> writes:

> On 4/10/24 5:57 PM, Alistair Popple wrote:
> ...
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index 22cd990..bced4d4 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -212,6 +212,17 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>>   int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>>   		const struct iomap_ops *ops);
>>   +static inline int dax_wait_page_idle(struct page *page,
>> +				void (cb)(struct inode *),
>> +				struct inode *inode)
>> +{
>> +	int ret;
>> +
>> +	ret = ___wait_var_event(page, page_ref_count(page) == 1,
>> +				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
>> +	return ret;
>> +}
>
> Or just:
> {
> 	return ___wait_var_event(page, page_ref_count(page) == 1,
> 			TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> }
>
> ...yes?

Yep. Thanks.

> thanks,


