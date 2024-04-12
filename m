Return-Path: <linux-fsdevel+bounces-16760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0474E8A2354
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287ED1C22049
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3B26FC6;
	Fri, 12 Apr 2024 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jP2cPeP3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F294A2D;
	Fri, 12 Apr 2024 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886016; cv=fail; b=F02ElDZLx8fZrDTE9YCSUOmUy+lveLgMLJtU1y9lPP4nxxFhzPnWFWCe9HAbYg21zCWH56OJU8/0a660aLAz6Y+Um06Hvd/gJAoJEhM9n9ZhTA19UsOV6V8RggAgarSFA0/tsShEau7hDlzTfYpZJYSS15TyRGfFLg7gKiQvnso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886016; c=relaxed/simple;
	bh=kYVmtYdUNEJBQZP1q2f35bPM9H8LpGujTinhAQRrL6s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=EQ+DKyBAz1FNIM7qqhZOScHCoCQrlhIiBYIFcCd+WfT5atczIGhpAjsM0kwajoE/Ny23Uq3n4f8na3D9dQ4qbdvhXZBYJlprd+xpwpA6Cx61P4wT5AmwXBf5UtxBuGzWCpgnzS9KNByx1pGcpgxvVY5ONbJp9tUfZhLcqBIduo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jP2cPeP3; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M20J/8Tko+zRxbU/03ycnVAyM+DTheRgnYIZ7DhAP0fF/tXSl3M8B0/cq6CXGcRqN6n4YLNVtuI1gyOSFpGpzk04dtwj8NkW1PF67bq/jdcB6olmlIO3zjKJ3SQ2uFin65E24u753hQdoLrbZ04fVVOJVohLkH2ZmkhzayrkbeYqos2ALCST5sD7g08VGmeqgWfqWOasrmtRmtbIIRFIchIY7+Uq2qO5qPRkW/8a9rkR3FntFxIB1ZmTk0OLT+z4GIAODmguU07t+rACnLI5jBgQPGceq9SWOXaY1r4SJt+HcDG2gfu9JpJaRD7FCjU5U1odVAxiCtLFViyGhWSSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKb2SPEd2Jj+p7x6R+A1D/zmCbRfA/KVHa3+khj9Mzo=;
 b=kV3zZm4OLP36zKwpKkeovbAvctjv1PH9GNiIDA2pXu3ozlFdgwf/LV98FNlOSeqDGTihTP8sB9v7AmpcYui6T5/KoJaCqF7XPuLUE8moVzCbx+Ea/knlVMB0szQY0g3aoq/2513zOPNmCMVs3nqyqOezQpiwJUX5BsOP3vdRBAQ5z+mZF8ZURFqtNk0GEmz9uyawv+3DojC0wCpipwH04tlcmKH+cP0Fc7qWhW9i1Qyp4L8yC0G70FApJXquWCm0MRqed2Gx7zfkwSnh7crsYtfJbyB/INE95kCzae+D0uOJj9RgNwu5Z5XmMQlArDDP5bH479v3hew/YU79RxkI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKb2SPEd2Jj+p7x6R+A1D/zmCbRfA/KVHa3+khj9Mzo=;
 b=jP2cPeP3J3yapIMSOwBp5uh1sQRWBB6OKYuZT+dvw89GsrPtooeM37RsDO2SftHaZiHkgazBhLyrWXMQLW0oDt5ixSG8vCqjcjrNS5GH33mPjHvgRLspROGpiB2qQvDxwO2VWjtybB5kKL6xlnCIMdJSWLoXhhjhMusIhDjV/4q0XFicLClUzIBjyIZwHayrtbz/grv3DklW/utNj3hT58PPr0P762fB4XeMKLsvX5JLQEv4X3MA1OjFjyuU9NKCFtDXwop6A1TeJnR8XWH7gfzPqvOK4onqiusMV0vU/opIde8ZUH9uROqoB3YlsCaqFYI7gBh0LILBYncLHEsQeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 01:40:11 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 01:40:11 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <9c21d7ed27117f6a2c2ef86fe9d2d88e4c8c8ad4.1712796818.git-series.apopple@nvidia.com>
 <ZhfvT6SXfCR60NAG@casper.infradead.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
 jhubbard@nvidia.com, rcampbell@nvidia.com, jgg@nvidia.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
 hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 07/10] mm: Allow compound zone device pages
Date: Fri, 12 Apr 2024 11:38:46 +1000
In-reply-to: <ZhfvT6SXfCR60NAG@casper.infradead.org>
Message-ID: <87jzl35pfv.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0057.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::8) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 040de897-3c62-4e5b-9150-08dc5a917e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VliyuOdsbZ+vzHz4gnwhYLDSbNgUGHzAMtyy36IpJFZa6qZI0GgnJUG33Ka8wfTQc1diuiJdNlDKi1JMh3iji3vfNroeh/69JZlENCXqjjSUSgmNhAZkgn7X14m0Na8LwqoBEOYZpZ5CWAKWWwK9qBlPMNSv0AHtPGGvEFUtlQxB78ZjXAR1vwtVgFaconpGXH92RtgCx3KPfTw8crw/zpEX74UT29dyfPcwaQ36Pv+7ALi/tBl9QGGIB8ETYbcnUF1LvAZMuHyrx7Alq97joYW6m5AGVIt1rhdmqC+IiTbguWF+wBvWFvu7tsgorq5W6ztu25XnIaUllGwxFobAjq6Tesb8S3Q6r2J59scbxdWARmNYVy6h8V3hk/1cvmoJI84trq3bXmKZj2xdviseJVWvjnk8rjt0CYzkMz35JWY/Tf4sQvps/8h91lrUcEAZH9KvW1nbo8LJ7wj4dUCmg7hqngA/q/hG3AWer+pV1RqY/NBnbSsP9VLg2W37T2TiUfEMP0zhZMIvjkpm8dt278FXeTX8lMhyVI6kGtxtE/gMP6Nsls6WIp8wIOpknVlr7aJX/FNi4i/MgEs9N2TbUwUld1voOnKTNK+20ZU2EKs06Jxf0Pv03CHKyjTIrKKHXJPuIcnfDxEKgTJtVhFVl88kKTFUvPpekd7uAI2KgTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NnTkUYZbFqZ/AIiBgmIexRtdaKlXMFPOD49B7U+LfoGOrXW2E3i0wBPPWpvU?=
 =?us-ascii?Q?DCfohZDBnm48vTgKWuot+oq0dfhizMy9c8G8xIO+sT0B20/pQ4q2M5BtCsLv?=
 =?us-ascii?Q?yoaxZ/vnRGZKnWK4Gnyayw/WAu31xLQ9fUrcN5hiUDkfiepjFUoi0QOKYzAF?=
 =?us-ascii?Q?Vbckv5VmmgAf0/dlPu7EF6AMj3tXqlkItI4zod09IMJSEoTrV11KZmUYtxnv?=
 =?us-ascii?Q?QVkaectua/MKXX3CakOvts5WXcWEcpSfBuj+DahAwuNt5c5Y9DSsr6Jy3rwc?=
 =?us-ascii?Q?bto+GdFIdsYMWu6nkdZHwk5J8fHizvVJ/IMaV4vxVQqC8GDjfvMQePm1ALOW?=
 =?us-ascii?Q?lW3gcO12HeeQ21+rkBTAKBU49N6XEqfu8CKsGMaHPZf1bAY6Zn+4YWwpkNil?=
 =?us-ascii?Q?xFVRvrExyIXQXEUsvTXRJwc/fBKVMWSTXbpW3QCtHP9aXr19qVwnrzBuz+vZ?=
 =?us-ascii?Q?EQhKwgCryS93t+Q3juV7cj8cq11zfoG/Li7Cn04z/UQG0feFueb7Suu6Zxjo?=
 =?us-ascii?Q?EDO9ZHLTNtgonWtUuLTge/erlaPRgAVuWlOxzSWz8WqpXFoU8Pyjctu5Sag2?=
 =?us-ascii?Q?F1p11tYciSsMvsceI64O1+xluc18nSI3igip2GCjdVYLGDBDEQ09rMUo15qq?=
 =?us-ascii?Q?taNjD/2pcAyIQAu/Dle/5n1nefQo3r0w4/v4KzDn8KRM6NuqQzfZnecV2Ven?=
 =?us-ascii?Q?RFV+wNlcYuVu1EUaH9bIa20L4kkF4ri3Py0CY9dVWr4+sdkDIqJCoJOdboU4?=
 =?us-ascii?Q?ScSS7TcBjRY7yEclBUkpkp+S0moKE/lDxh7rRQTBffNE7Es6DZurkG2r8dMm?=
 =?us-ascii?Q?q/xNLcQ+ewZWxqCgshuHiwy97J30CpgWKjo7ho9mXYjnlVEEQaDoXkI2Ibrb?=
 =?us-ascii?Q?GpYbqsnjodb+JFw5upBvWDcaKvGjb5IgK5Et5ulA2PyFrL+fMtZjAg0VW9bz?=
 =?us-ascii?Q?6Mi+AQtwnXaCH8qwBl7dSbJBvUJ/a8qn1Ef7ow5LmM/Ocym/VZNA4V0isjSC?=
 =?us-ascii?Q?SsDyiLHYGwCYtu9k33LAKL//k2aZJCJedYMeCoj6g+CQT58h80sdz07OL2Yn?=
 =?us-ascii?Q?kY6jJ7SiPMj1K0QWPVQYfvVfOrB975mrNv+76pbsyvOveIFAn0r7DO6FAEMV?=
 =?us-ascii?Q?glHkhcYArIJb7Ly2OiPna+4dAIUIo8+0J4/jdyHBk2Vk9cCI3WJ6lH5sGsZE?=
 =?us-ascii?Q?jIF8suGpTg1DpY2pyqMFcMcCrrPCmwgPsaCK0pJ5j18kCaNruTfPb+WvUTT3?=
 =?us-ascii?Q?OcZYr/BVqmi5GjwKdqKuVkiQxhkIPpsPk2OAOy5pgNOAaPPD5Omz4i3OYCv/?=
 =?us-ascii?Q?11d8Knml6T9/1bDbsph/rsp+nAGzl8Z4TWR/xJAsXlqLP5BDrWjS3rI8UkMn?=
 =?us-ascii?Q?Ywc7XECOZPFYtF93hjHrdp0qJeZ8qWjywRpH7kwaBE3uKEGBcuzTsi3SRpij?=
 =?us-ascii?Q?w7uUsHFXUpC9NGYWuu+ds1QJQbdf1nEaGdJberFCFa/G82b5mBhLCqBBtvGo?=
 =?us-ascii?Q?xZSMUTbirD9vfIviozy8rQ2kgvLj8bLhw1/u9L4ZVWKHVDFArzWNbnROfOOQ?=
 =?us-ascii?Q?UOSuLfXjft7X0LyAkPaMespnlUav8By7am/tWrw1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040de897-3c62-4e5b-9150-08dc5a917e14
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 01:40:11.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ok+i9emM/gDfDgSpd8dKpwHXm3hfVJePJAXtwJ+6DHMW4PbLi4Zqj7ZzxvMCWU13kye/Z2vbWJYoeUHfux+xlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540


Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Apr 11, 2024 at 10:57:28AM +1000, Alistair Popple wrote:
>> Supporting compound zone device pages requires compound_head() to
>> distinguish between head and tail pages whilst still preserving the
>> special struct page fields that are specific to zone device pages.
>> 
>> A tail page is distinguished by having bit zero being set in
>> page->compound_head, with the remaining bits pointing to the head
>> page. For zone device pages page->compound_head is shared with
>> page->pgmap.
>> 
>> The page->pgmap field is common to all pages within a memory section.
>> Therefore pgmap is the same for both head and tail pages and we can
>> use the same scheme to distinguish tail pages. To obtain the pgmap for
>> a tail page a new accessor is introduced to fetch it from
>> compound_head.
>
> Would it make sense at this point to move pgmap and zone_device_data
> from struct page to struct folio?  That will make any forgotten
> places fail to compile instead of getting a bogus value.

Thanks for the suggestion, I think that makes a lot of sense. Will try
it for the next version to see what it looks like.

