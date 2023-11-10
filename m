Return-Path: <linux-fsdevel+bounces-2719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B8A7E7B77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 11:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB0B1C20D3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0C134C0;
	Fri, 10 Nov 2023 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="knAgPEsx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iATv3wx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936191B27B;
	Fri, 10 Nov 2023 10:43:13 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF282A259;
	Fri, 10 Nov 2023 02:43:11 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MY4pl020612;
	Fri, 10 Nov 2023 10:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iCzI7XjeEgXg/EedqNUJMiOzFyfDUFullLrhRjDu1po=;
 b=knAgPEsxiU3W0xeHGDAZv4KeAk9Cw3Cndc1AeYokkGxzQbgfCdr9XQK9DKfVyzlMVIi5
 Wdt0T90xaKPPw3IVXDHSWb4dVdhvAzuO/wt8KSooBESncJMQPgIeytu2vEiCOotDcbH3
 IgK7r94g5wvgrfHV1yi5QGXpiEiWjyuKqmw4AqymFHcxOaz5Sw6Z5v3tj+66UWypI0gE
 pBUlHJYAMsSvb9W+AbiEcqEffAEmnPym3lVi8glrChJ+X9ZSBIkKzBRbPn5R8KrNkkT5
 NSXjXOGwyrKVFIDOLTI/Fean08rLXpjfy2+OFK096zNwU4zOPXXN7KiIIG9mmD9rIxrB TA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2263p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 10:42:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA9D2SA024820;
	Fri, 10 Nov 2023 10:42:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u9fr6qd25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 10:42:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxdbjX02Jv/un/CM9doWOwkrrb8yGANRRLZ58vYWXoFLFv97AAm08seWEH/qKm8iUCMEQ59mC6Tf8Rhc7CfS5y1eizcb9SvNDOcZ9FQm4DMtnjdkSwAz0LpCtrE8L35tSwjLUu2rAFSEESqsi7OI/V+X+yb15U3/jpXVveO9/9FPbFE8qY+11q1RRGTrcYWvGz9Ok2BPvKZNageFBi8r0kjXJQkDM/q2LuwnYQgoLNdcg8yDyooaPfNJdeNem/O87FV2BzMjMVTh7vJjkhNSm3fJTmN51EW/vT0kmanZKHvDjKfDiqXlGXw1JkJrsV2x17crAA2oqqTIT00LI8pmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCzI7XjeEgXg/EedqNUJMiOzFyfDUFullLrhRjDu1po=;
 b=SWlSTj66QXg3D5N2YkRru7K0ILRf3olsyu0KlSRM9wHeycB4e5cqYK0sOSsXDjLARz/ooO17YBy89aj5d8CbDvpNbkgpfnyLf/PDCEVOxEk04FomrQjqPPiPfUIcTnKtXwKcXsQbzBBJOKH4cKOUkaj5sMU59+YJGuIIzJBLUm6CYkaguIVPs99KivQXf4uQDwUYNYc3a5hSI9v8GgB+N6tvksx3EIhzKdvLQJFTBgnEgM1zInWOlgtyRMaYJ4O0+WHwhqVw5O9TG1u1LKWYfrL0HmSyF+4Y5C2cM8OQwMFBxqhTkAHCmR+/TImWerSiMTSUrMxCcTIDkXY9ukfThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCzI7XjeEgXg/EedqNUJMiOzFyfDUFullLrhRjDu1po=;
 b=iATv3wx79wjiia5Nt8GTNPuUCKD0mcUrfzQ0lDiBmAnemsICwwcVi6/FZjQbJHZeEgvfVcbBsad1M6HoMYu6n6xfbcEEkkpq/0gG0AS9x1Ul9DBzVpB4OmZSfa+F7sAiuLUxgGWFbIajmgXfiqrP3hF8hl8HqJc5lhM8feAG7C4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 10:42:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 10:42:41 +0000
Message-ID: <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
Date: Fri, 10 Nov 2023 10:42:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-18-john.g.garry@oracle.com>
 <20231109152615.GB1521@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231109152615.GB1521@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0420.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW6PR10MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3163f9-2201-497f-a631-08dbe1d9c408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XPu1m7YIFljfOEbjQoQ23uSSZc03dLd6b8FfcBaw+n7B3TTtawSqIYdeuR8Bg1ryVf38Vhx6GYXG2GDiXhRl4kUqzR9Kwjn5nJZkxUlVZ/tZ9NWOl4vrJ2Ecga4l26KJmux1Vy5Ruy4WDeRvOOlOZb465GmVb3yG6ZLwYIqxCuy/LkuSWv93dm3N9fyWfy6E0KKusZ6iLcHrIiDTKZk57UDNKSjWOefPQ72jhSNl+qnt6aLAU6y5LvJdHN5xowqiSr0u1ts2y5lq04ekDHO3fGUmqgE5haU6ubvYD24BhR0MYJ9dX6X7Mhek8H76AxQ4fZVhhkXsRvCGIrabKjYVXtkJZuBDC/4tOnXWIYhtHJQPkCPyvdiJ4zJ7AzviEZGFIwJXliQS220PLdHY2xky1Fs3mmgCWvWosQcXgH3lUmtSl4rNAsRDFQlRpDsFwtH7OTq/NU+cNltWO3xurVNmYoFyqGG1FyJ8SIGT0NUrh5tJv+YgQ6I2cnBzDh/z5FsgR9IZILAyAmyowmweF3DiJ0wcEKA9kov9zjFGS7v3+sraXAIS0SCW/AGSfmPUdFPZEmNydjubbv2VwF+TPGlgWUqXzPIAjoVNrZQreUWF9DNL/NfHdiC+Fv82iPQU4OA5N6KgVDojHn41YyqLUz7o7w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(31686004)(6666004)(53546011)(6512007)(478600001)(6486002)(2616005)(38100700002)(36756003)(83380400001)(66476007)(31696002)(36916002)(6506007)(86362001)(7416002)(66946007)(66556008)(4326008)(8936002)(5660300002)(26005)(6916009)(41300700001)(316002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGgvejFRd2VpdTF1c29YTWRydVhRTUZ2TytmMEU3UkpkdjVZZUNUQTN1NEFk?=
 =?utf-8?B?UTdaSVRvSE9GTFZMQjBWTm1meVRBL0FCbEhTYXppV01JeDFaYXJOVVVaamw5?=
 =?utf-8?B?QXlIaVBla3gwR0M2djJlVi9qK0VHdkcxeGsvR2IwWDRJWVhrQWpxK1hia1lm?=
 =?utf-8?B?S1FRQThvd1Zpd2czdGpnQjRkUnlOU2NmSFR5Q1ZGM28wZ2psL2UyTkV4cWQ4?=
 =?utf-8?B?MnNqdzZuZmNhTnVBNDlLRnFaY2RwZjZ0bFo1MTBaUThHRUVLd1lKand3enZu?=
 =?utf-8?B?MWtCODJ6ckIyM2tHaFJldThYYUZmbDdvZWMwb3JjSjU5UzhCbjcvTWExcFlr?=
 =?utf-8?B?a25EQmpmM1FJQXlvQk5tSUpwcnJrUU05eU44NTFiQUdFVEQ1eUxUOGpaNXlQ?=
 =?utf-8?B?TDFnUmpIcTFMWldHNktYMWVEQmZHOVhJbktvUDJDRTNOdE5SZGR6Y3RrN3kx?=
 =?utf-8?B?WlFCK3JMSmEwbGs5WDZ0ejUvRVJTZTFpUHY4eVhLNkRIUEhhNGt2dHp4VjFm?=
 =?utf-8?B?Z0NnNGZSdzBQelRhSFptQVVsam5xREd0bnNUOXQ0VW4wRHdNMmc0V01yOHJw?=
 =?utf-8?B?YzFsb3lQd1oySzBidkgzUldKbTBaSExnemI3c1ZBRkhYRDZkcjhQZ2dFUUU2?=
 =?utf-8?B?SWQrcm9QU1ZBcEtEZjhueEsxMHJtVE9IUi9hN1M4Y1BUQ1NGQ05mSHUvL1N2?=
 =?utf-8?B?MGZseXVUSWRCazJDRGZFK1IrZjlralRiM2d6anAwaDU0L2djWUZJeWk2MUph?=
 =?utf-8?B?c1FKZWVTTmk3NkVGYlpBYm5IeWEvUWtlRkdEYzJPQjdhTWM4dDkwR0ZObS9q?=
 =?utf-8?B?dE4xSmtwTjJRT2drOGJWM2Y1NDZIZVA3MTUrbHBzdHhhSjd4cDJSTUJXSTdx?=
 =?utf-8?B?Rmc4eVVBU0UweUYxWWlBSkVjVkdmOUIvMVV4U2I3bytENGgydmxubndWWWNz?=
 =?utf-8?B?MXo2MkJyM1B6Y2U0RktPRUx5TTdtcms3dkV0NzB5R3dEY0Z2WFZuT1crbGdV?=
 =?utf-8?B?TFRYZENlNHJmejV3dThPby81YUg3dUp5MmRBeXRnelJLTGRkV2U3Rzcvbzl0?=
 =?utf-8?B?T29iVklpYWd4bHFoOGdxYkZ6ak9QLytYUXV0Qi9JU2lUOHR4UlMyMkNKMm80?=
 =?utf-8?B?L0lkL2xSWkRydk1jckR4RFRSYW5TVURwVkpoK25ab2MwQmZEbEM0cnpFTDNZ?=
 =?utf-8?B?aHhhRDB3elNoSXlpQWRSMEsrdGVwbGk4RUhDQ3JiOVovRTl6LzlTWDZmMlpN?=
 =?utf-8?B?NmVDRlRLNVF3c3FmSlliczErVjh5Q0x0amFwWVVodVl6MDRTRmxZZlFsZENZ?=
 =?utf-8?B?eHc3dWRLc2NUdnk5elo2NjBGQVZoUDRYbi9Fb3duTENGeWhYRzJ2Y0VVNDlG?=
 =?utf-8?B?clBhMEdJeFhlVzRWRjFGeFhGTWlGZUF3UmhsMlpSUFY5MU9TUThjN0NCMmJ5?=
 =?utf-8?B?K1BHYVVNWXltQ3IwbHVBMUNiRXlUM2hweE1DRXEvSHlNZm1wSHZES0tvZTRa?=
 =?utf-8?B?Z2xaK3RTVTVDVGdQczV0aThUMHJNSDVpWDZwNk94bmlhd1hqUm9XN2doMkpt?=
 =?utf-8?B?aXdvZnE2OVlhYXVRTjBFMDlqL1p3OUN0TVRKc2lmWmZsejNQN1BPVisvcDFt?=
 =?utf-8?B?c21TeWRDc2l3eElMUUtVUFF4Z1pHRk1vRVNEWXZGb0Z3SHgzT2QvbnpYaVVl?=
 =?utf-8?B?ekk5bEZ5STF1VkFZZGtWbElIRkl2UGxwSFUvZGlmcldtRllxQ0QrUnZtd1Ix?=
 =?utf-8?B?RVpuc2FxaEdwL3FkRDlIMGNtYWpKa3F5VGhVWmlxbEJMWFpXUGJjYlRpTytx?=
 =?utf-8?B?UXRjWDRzVDFKMGcwNFBXU3orZDBjM05Ld3daaGVIQkFiWFZxRTFoYTIyV0dX?=
 =?utf-8?B?OHp0ZlFQcHNWcWkwUm9LT2dOTzZFMitOOUdqMG1ERUJ3TUltUS9EZEtPQ0M0?=
 =?utf-8?B?TDM3NGhJZlFnSk01akRnby9vNGJLbXhtYWw1S0tYamxJN1VmT3hOdkZVcEJM?=
 =?utf-8?B?QXc3TnMzYVZlSUd1bEZVZzEyUFpUQmdxK050ZStyV1BoTkRPWjBkeUlEcldZ?=
 =?utf-8?B?QXgvdHMwMk4yTFRwanhDWGFHV1FtMXU5VjNYbk1ETmJrcnRsYjVqVVRKUjlV?=
 =?utf-8?Q?ehgrcgtdIa4HUHKKzZ5q1FDYv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?eHgrQytFNzNLOVdnS2hrYlpEK0g0ODVlTktDdjQzWUhtT2JRMHN3TWdtaksy?=
 =?utf-8?B?cE9SclB5QW5ra1BpeFhZQk5halBLaWVpdmNyVmNhOEZKV0dqd2d1Nk1sZ1lD?=
 =?utf-8?B?c3BEekpLYzc1SERJc29Oa1NXWEpoYUtlRUFyVlp2VlA5TEpKWUV2QWNqZXFZ?=
 =?utf-8?B?ditmOXl6ZnNpdDNhTzZndnVJSEhhTTJKdzdpK0NUQzA2c09CRDJFV0JPR3lK?=
 =?utf-8?B?cFJYUS9ybzgyNWYyZHNGSG1WN2FDanFjOFU5bzNKdEwvZnZPS1JDNm02V0U3?=
 =?utf-8?B?L1lnVVhEYzB6NWYxVHRBekZ2aUxiQWdnN3NLYkdhbU9mZTNxTkVrbEF6UkEr?=
 =?utf-8?B?Rm81QzMwWnQrcnRxVUNRcFdnNjMzOGh6RUJmU3lqOFB6RDV1Y1BqZVpoUXNW?=
 =?utf-8?B?TE54N25yNGlITTcrWTNzWEMrUWh5djFGTHA2Y0hMcSt1d0NwZjRwN1hHSmgw?=
 =?utf-8?B?b2R6MHk4ZkxUTTgvMENkb3JYN0R4QjY4ekp1TU1DNmlFaUZzU08xU0ZPN2Uv?=
 =?utf-8?B?aXU4WHg4RHBQL0p4OVlSSk1XVDVtK3BLTjRaaHVaMHV0allFTUx1OHBMZ2Ew?=
 =?utf-8?B?VXhGZ3lSakFNTk9KclZBbkllVTNXaHhqWVZGZ0JOY252OU5EVGJnTU9taUdK?=
 =?utf-8?B?OWZ2cGdDdEY4SnVDV0pQb1NPeWRkMWo1ZkRNUzRoWTRZSkphT0huSmN2WjFZ?=
 =?utf-8?B?Vyt6WVBxRzl4Vkt6RFJ1dEdMVGJ4UDRST1pPVGd2d1I2ejlKcnhYNXJyMU9E?=
 =?utf-8?B?U3M3eUNscjZsYUkwQkNtTm44RzlsR204YUx3Z0IxVUt5YVpMVGpBMVJROFlH?=
 =?utf-8?B?OG1nNDFuMlN1YW5LUCsyOHdwbVAwZkhjdjcycEUyQnBTVVlTYUNOY2Y5a2xV?=
 =?utf-8?B?YnZ2WktlZXJpVmJPaTNXVXV6c0duUld5ZXlBcjBIaEY0TjVVTzl2QnFna0Q2?=
 =?utf-8?B?d3lENkRvVHFoVnFMK21kZ3ZVR2l2b0tzdDY3OVVzK3ZtSXB5NjBjWHIzOXU2?=
 =?utf-8?B?RHJQc04rcVR6VEpDTlFuTS90R0t4SEdDQlJTdHpSd3dRVUFWV2dpMktJcmVt?=
 =?utf-8?B?ZlMrL1NrS244NzU3NFF4VnZIcWNaeWlIS0E2TThjOVpuVHd5dEFLZVdNcG14?=
 =?utf-8?B?ZU1OUW9ZWkJwb1ZMTFowZ0s2WVVhSTVicFlUOHdia05PSkFnLzRSdnUwUWlK?=
 =?utf-8?B?ZnQ2Y21obmgwQ29lT2dneXJjdnMzbWxiV3JFT2RQaVpFQlgyS0lsODRKdkxw?=
 =?utf-8?B?WlZJWVhtdndNcllyZ2tpcENCbUxDNzFSVnpxTFBNZzViNlRmZ2tyVGwvY1lO?=
 =?utf-8?B?bmpyWit4bWQvWThHWmRaOHZuZzBKYy82NG9JTlRXSEM1YTh6UWJBSlV6M1E1?=
 =?utf-8?B?cis5MFdtR3N6M0lDcHlmUE9udjk1amJIKzBlN1BjYXl2TG9vbGpxb2J4dUs2?=
 =?utf-8?B?TC9DTmtJd0k1cVlzbzIyWXViRUhNbG1FK2pBYzFRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3163f9-2201-497f-a631-08dbe1d9c408
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 10:42:41.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu4gWr4B8gl9pgXw6i6336kEh1DXZwZcAp1f1Bj5l5o+5Kn9YBbr6zylozEnyN1Swx2zlAzmKiOlpmdZozzr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxlogscore=820 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100086
X-Proofpoint-GUID: 287iSq9G8h5AhSL-f_Dw1ZnDwkaLLuvj
X-Proofpoint-ORIG-GUID: 287iSq9G8h5AhSL-f_Dw1ZnDwkaLLuvj

On 09/11/2023 15:26, Christoph Hellwig wrote:
> On Fri, Sep 29, 2023 at 10:27:22AM +0000, John Garry wrote:
>> Ensure that when creating a mapping that we adhere to all the atomic
>> write rules.
>>
>> We check that the mapping covers the complete range of the write to ensure
>> that we'll be just creating a single mapping.
>>
>> Currently minimum granularity is the FS block size, but it should be
>> possibly to support lower in future.
> I really dislike how this forces aligned allocations.  Aligned
> allocations are a nice optimization to offload some of the work
> to the storage hard/firmware, but we need to support it in general.
> And I think with out of place writes into the COW fork, and atomic
> transactions to swap it in we can do that pretty easily.
> 
> That should also allow to get rid of the horrible forcealign mode,
> as we can still try align if possible and just fall back to the
> out of place writes.
> 
> 

How could we try to align? Do you mean that we try to align up to some 
stage in the block allocator search? That seems like some middle ground 
between no alignment and forcealign.

And what would we be aligning to?

Thanks,
John

