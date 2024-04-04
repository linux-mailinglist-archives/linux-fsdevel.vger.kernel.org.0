Return-Path: <linux-fsdevel+bounces-16095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0158898161
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 08:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F1E287892
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BE254915;
	Thu,  4 Apr 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ti4QNbMG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2090.outbound.protection.outlook.com [40.107.96.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AB4E1C1;
	Thu,  4 Apr 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211526; cv=fail; b=RUIMoM8LQS1OvChcv9ACRTqUwIHxN9QGIKiSDUgzp460N+bVWatZnxbx5O4nz1W0NzsJ0uOt0LGrq8HrTouQ88eUuu37/Pqrfo/65ANpQm4vjpnK6nTsh6BwqU8dw2Iy9pjK6nQozQjO5TU2lMs+YQqtGhL0YerIPXiHeFLj67A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211526; c=relaxed/simple;
	bh=5iTFWYeYYgk3kmHc88d3wERfQdd7HrN64KnxhFxbULs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rNLe8A7gxEBw8awvHcs9QveqweNVFnmyq0EBUgDR5sRG+cerjx5Ez3iU+2jpYDoO1DgWUtYVWiYxl5Xn1PMqguiRQBBsADQ2lGo0uD4uzjL6j9VvEjGfS/9CBVfaUO85hINqZUG7rh8uylIuYZh2MooGCpwpbrMKxfrZLbqT9Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ti4QNbMG; arc=fail smtp.client-ip=40.107.96.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtjhKVM57qU5y5mv21WhFCs5hmRlaWNCq448k1bPzi2WieaYQjYn1woTffeSgIKpkiDamD0jmhHDh0as/gRP28zjdAqdqq24V6kBdBZDQz72sU8LZMbItfS/0uJiZSJAG2n3KNiOl7zIOegIrfTlwwNmYHCtyhl0VLPX6ce9surd4HyHY+G8Tgz4hvV6KjfBsgP3qIRRhKzUj98RvcZFsq+12j6iktqgyxbCJ8WNwTX3hc/uGwAoaWzvi5fng3eckMR/WR687u/62af4VdtGNl4M9o7g44HlVdOFfUHaezvAkoDBCkRzhK3/V/d5esxm9udd9QxI9loChKJaGgPNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGUygyizDVzBGCSeklfWFqq/09oRo1P3p2+NVZdNwPw=;
 b=C839bf3+/3gt/v0gNUXxnJ+SAWf/4Q5FmBDU830qwOvuSZhImOxKK6oGv3z2Bnlglcla1b3ep4zxoLnlDtb2G1CZmAmz0mc7zipgXVxQD2Fo5gxnuMEwN7R1hndGLzfq8blvBSK+/hax1WAhUmvyJiefJz7RX7su5k+xX0SG2Msulwcxp41GzkTJahYTA7cqIAFdwNz6qLGoruLZIbyPtBsKFLoqWn3YvdNJmUDIOqMmQy7CZp2ls/6gjiSGIDigEpzrs625RG/RJTWd3g7e9r3YwAfepq3pgB5lFppjZ0dbk6pHJcAsN0NbotriUsW2GGWdYsa7TtvwniRW6Yv58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGUygyizDVzBGCSeklfWFqq/09oRo1P3p2+NVZdNwPw=;
 b=ti4QNbMGBNM11dvPdJwSfVherCTjHD0M9T0gh6aiVYmr24jCJLM2CmPr83JHE6sLvLd1PaOFrEeWjo2lbC5T/D+tRUL2YVGt42dDvRqMQH7RP/VzI1G3q0giXgFk/KH9oEjlZ20JyP4BIaqx+MWELaJUbl6Q14dS9WSfz6zS3Pg=
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 06:18:39 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::2385:dab8:fddf:bcba]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::2385:dab8:fddf:bcba%6]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 06:18:39 +0000
Message-ID: <a30d9ff5-638b-9d81-2c4e-8afd585d437c@amd.com>
Date: Thu, 4 Apr 2024 08:17:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 21/25] nvdimm: virtio_pmem: drop owner assignment
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Pankaj Gupta
 <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
 <20240331-module-owner-virtio-v2-21-98f04bfaf46a@linaro.org>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20240331-module-owner-virtio-v2-21-98f04bfaf46a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0091.eurprd09.prod.outlook.com
 (2603:10a6:803:78::14) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|CY8PR12MB8216:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3FffiHvmVY5igagMS6HFuehymN9LrxeNdbbBXpvUSfgEfgdxTVr0Vaf8j89Wo8MTcHWDcxWZuXHqaQWzC1xGreHIwkQlKqYXP9K7Jf7Wof4aSKqaqFpgwFQ9pQFNmtJgSNcCi1l/QrZu/BXkxbkpkcXTZVQKZzZlJ75zkWDe0uKewVkzQF73JuHopJGJ/oG/PGDIKlFOVfi+jY2fd95vjvx3qRqLKO7nvsq9tGlZPBZU44UyYxtaRAmrND6VASBbbEoCSgjURHO3hOPqVBOk45UDBVERXWbgA9/TzPvbujnAbXaLrPKMcZDlkgJpuBl99f7JLPU3TT2tJgZTIhzMLAEw9RCd40ZkAw8Arls5SKlJJ0HDaxPia21Hpca5K3yAOdPSTkqewkBt/ZmPBdAdXfP2N4HAWcTdfHVfeOZFOz3iJHYOUFV/+qaxiYXtZVQtj7HcfBKhMc8z9oofKCUT+Dj4N4Wo0WXh/Z+GqdXb8GIWmjQc1ZIS2cT9OdMzqyDqY0yLuI484nGakhcP/Xxxj9ufPCoTzeBwrqQDhQEeP30d1ju7hOSFKoMMthe43blFzVzkVvVoeFXV+tq4uY882/gIhOInvww+65Md4boluQociatlug6mB0lKm+osdQJp/aVYOSkrbIGG4z+Pq1AqaYF5jLjOXprj4ECvWOZAMer2ZmrxLsYz7Y/k50YLQlPmvbCl1RnyW9hLOwJuRdw8Mg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NldqM0VrbkFNditIdUI3c2JSakkrOEJHbnczZUpuTzFvVWxZaTdsUTlvejZ6?=
 =?utf-8?B?c0VKVjE1eUo5VWkycTRoOWVlc3ZQMjFkMHZrREJMSFEzNWhJa0E5bkh5bFpt?=
 =?utf-8?B?TDdISlpPcXBvRTYwQ3RZLzRiK1hUcmZBcUNFai9ka0dGUWtvbHNJdWcySEw0?=
 =?utf-8?B?M1RKU2YwdFVnZE41M3pxanYxSmZwdXZ4dHRSQlRCc3V6dTllY3FIeUdpTjUz?=
 =?utf-8?B?aWU2eVltcU9uWnV5YlRPdDdOZTRlNkRIQU4xV3daTjRDWVIrenBFWHg3SEVK?=
 =?utf-8?B?OE5ERmx1ZHNwSUZGWTFSMG5TQnJ1eTcyZGx2UXhWTTJtNDIrTHpmeW50eExm?=
 =?utf-8?B?blhZMjNlZFU5NEpYdEVrc3Z2WlgxOU8xTHlwTHVwa2RLTnFuOVhiQUNnREtj?=
 =?utf-8?B?Rm9VUW5vcnZ6R1ZJU1FNeE9hRXJzQnhDQ205dUw3RFVsck5KNjV4enVXY2J4?=
 =?utf-8?B?cGhxZ3QvWHJkbHM4Ry9iTDBxWFBVNG9kZmhHbVhWZlNDdFlCQ0xmNGRYSmN1?=
 =?utf-8?B?WHJ4Ullidm9QWTFZdmQvNkVrRCt5cVAwcGJDNC85NTE4UHQ2LzNVOGNPYk1T?=
 =?utf-8?B?ZmhsWlcvQ21yb21YREhSOGlCSDVTajZXV3cxOUlpTGxlQTQvT21WeHM0REFU?=
 =?utf-8?B?Q0ZlV2I0UGJUZ3hVbU8wVTcrd0pBejhtNzlobVp4emJFN1RvVU94REYxRWxP?=
 =?utf-8?B?a0VTbnBYZzh5NUxwTnNMamxnSjUvdkNXUHpyRC9Nenl1SGVpNkQzeGEvZGtY?=
 =?utf-8?B?cWptOVQ3dXVENXNiY3FNK3d4TWFqSFpGTkFiQmFHNHB3bHlBeGpQaUovMEoy?=
 =?utf-8?B?Z2h3d3NzN1JMNkRaSDB4WHIrMTA5b3dSbGdhSHh0bWZKVjRrakMxM3FlNmF6?=
 =?utf-8?B?Y01rYzZJUWMxRysxTkwzTmRjYjB3SitiMXhySHdYdVRYN3BvMWJmZkJQNmsz?=
 =?utf-8?B?RkdTeGg1eUg4Q1R6Y1BUdFlOclBvRXdVdGRPRDh0TUphSXYwdnRSc1J0bDI3?=
 =?utf-8?B?dldxWlNLTy9ld2tUSFB0QlE5MTEzN3QyL1B3NHQ3c095MEtQNjNkMmdxcGVS?=
 =?utf-8?B?MDhqSGwwakNLaHQwbWQ5NzRHR2FHR290azFDaWUwVHpsSm5qdWpnelMwNzc0?=
 =?utf-8?B?RHV0SUVoWEtRK1E0S1AwaENQVWxqOG94eCtrejI0aEpReFlNRENaRUlxN0NS?=
 =?utf-8?B?dk5zK3Fua1NPZlFTNjUyRlhtVjVPcG85dHVnVDV2Q29NK0lVRWMxeS9GMk9D?=
 =?utf-8?B?QXQ3b29wUjZaWUpnYlNMS1VRdERibzB4MHoyamVNV3dEbWlZQlNIYzBpemlE?=
 =?utf-8?B?TG9yZTVZaW0wY2RPQXovVDdhMkpZNUVhcVVCYm0vaDNYNExjdms0MUtWL2tq?=
 =?utf-8?B?cm5vY3REcFJ6T1F4S0swb0wrVHhPVG5Xc0pPa1dnNHBNbmljZjdBa0g1SkNv?=
 =?utf-8?B?dmFwL29VTU5FRnVXNFJ2dDdXYUpOa0JLTVh4Tk9WUWo1d0pnRUJzejhRQ3o5?=
 =?utf-8?B?anJKTkpIV3FvNG9pWEtEaUhHNGl4bm5WL0U5VTMxQnJkb2xuZTBxOUsvTzly?=
 =?utf-8?B?a3dlRlU1WTVnWWpPV21SK0xpZEpnZEZpeDIwaTk4MFk5MjdSVFJGckF1QXln?=
 =?utf-8?B?QWNJZk42OFloK3crUUtxZndXbDVOWUZMUm4zRlBFM0ZIbmF2SzhpU250TlpP?=
 =?utf-8?B?c0ZJK1JhUWFQVDdsUnZBSE9YcGt5N3lCVGNLUGYzVTlVNnF5aHlnbm5sQVNJ?=
 =?utf-8?B?czRtNlI2UGxUbzdkSFN3NUZKSkNmTEJxL3ljakRLYjJ0dElxQzlwR2hjL1p1?=
 =?utf-8?B?MnNacDJuTE1CRWg4QUMvY2hZb0RkbFluclR2QVo1ektwTUNwK2g3eDdVM0t4?=
 =?utf-8?B?K0Z4cDlYaFpqZmtBNXl3NkdLMmNRQTNYeVNFcEhpV0Y0ZjBmRVZwSDN5dzFZ?=
 =?utf-8?B?Y09RcXZodG5iZkg2bFpCcVlHRUp2UmhNWVRFSU9uM0YyaWQ0a1c3VFZ3eGt1?=
 =?utf-8?B?dGpMa3JqTG1XSEc2NjBlLy96SVRkL2pEOUlpOWViTWZLVjNOZDUyMXY1cGpZ?=
 =?utf-8?B?RGREaWpOcUxFbkVBMXZHaVVZNlpmbDlJRkllOUIwbTV1MENhR1AzdTBpem1s?=
 =?utf-8?Q?qw2qYdOwELcIKPD9IK3bVT7xj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fc5c03-d3f1-407b-10f4-08dc546f0ca4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 06:18:31.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdOgk2JHQ+D4pOlbMfhFDQrfxUTlXRzHE0L+I38/h/takAwhkipgrCqw8gQk6S20PrFBvpBv4UbElXDU4YfCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

On 3/31/2024 10:44 AM, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Depends on the first patch.
> ---
>   drivers/nvdimm/virtio_pmem.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 4ceced5cefcf..c9b97aeabf85 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -151,7 +151,6 @@ static struct virtio_driver virtio_pmem_driver = {
>   	.feature_table		= features,
>   	.feature_table_size	= ARRAY_SIZE(features),
>   	.driver.name		= KBUILD_MODNAME,
> -	.driver.owner		= THIS_MODULE,
>   	.id_table		= id_table,
>   	.validate		= virtio_pmem_validate,
>   	.probe			= virtio_pmem_probe,
> 

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>


