Return-Path: <linux-fsdevel+bounces-6745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9A981B92A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB8E1C25E6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C753A10;
	Thu, 21 Dec 2023 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ERD1L6RG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PSOLCM4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7A539F9;
	Thu, 21 Dec 2023 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLDODNc009053;
	Thu, 21 Dec 2023 13:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=86frelLMZj2pRkvUF1zbDVcqF2Q5/4rY4W+KNW2yxlA=;
 b=ERD1L6RGe8GZQgJpW/ft0MsAMlt7I8Pl1dyXWvx/cWjPhe9DW8lANA0ZpzLgwxbQ0fRw
 Glf2cTkVLc+CQ+89Xd/0s2PkdDwn8dBI8+VF3zWa4huetDCstP00ITty6KTVgGUKeKo5
 qc46tl9iPdQnB0eYbIXcEf7UHl6O8/WXvFmsnQyAnBiptAQyleA2fq9m1AVuQZ8/879g
 QpEopXLsB8oGOwR7AA/36eVgg+scr9ztBzQnYtaXS5X2mfJsvqqxzIvybvCrDVRA0D9f
 3I6y9AZCxiAnP4FAovzc280CeVJxDoMwth+KsnVZYzRfb5HG2qqP90csBCamRN4EGYta kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13xdk1pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 13:56:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLDO7la039756;
	Thu, 21 Dec 2023 13:56:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bb6t7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 13:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHkgcAiYio/m63uIxSXMwUTLv0yTzJca96h4TUy+zcU0NHpuT/2iG3E/ai4XWjc9djwBZE1YFY7Ibvfapht7QySy9R56abnSIvS0GIGsGlHjI4FRbgHTPAbu+tPK1k3yX7DgnZ+RGr3O9ibTe2u80++AWUswsMOKXcRAehHjaScuAcGDiCyqs8nuPErH4E6OqLn+3aJw0GIjuHZagX2OPwXicdy0AyL4aQwyMMrnIjrHglJE1fHydZyjfCR5lmslsJ6oPA43dcfKF626ozZ/sh7Y2JhMYOW8zLzOisfNv3U+Af5gHapgWZCEoVf+waK2pWXkSKcT6Jc7wCWORBrLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86frelLMZj2pRkvUF1zbDVcqF2Q5/4rY4W+KNW2yxlA=;
 b=f2LtAtyO+VK9+Crp5j/wvTAe4Q5iOmmFzNPBcM+U60Ro9vS6dvukfbqiwdrr72KRSZpIE1wJ1pOK4/+reNxSRC2nzOzFnaJw+QquZHN7EwWRrzY0Z8oVuM5EzGhbA0pfOja/ebNtIgMjMzduF9ErYa4pGcHguS2UyoHKkXwsZ8SMd4RWpa+owSfiAQxZPaUaanVvr3JrKd3Wl00xZiDCHEVjl1z/EZwql17qoDsrrwY1LR4qHfxSixyIC23n8gMBNs/gTEgMZ7R9NoPCIELnR7E1Kzhn0JjY1xIeG+cEKVXRIr8M5A6VE3f928njoIPGYMM8VKNnutFTqBZzMWhisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86frelLMZj2pRkvUF1zbDVcqF2Q5/4rY4W+KNW2yxlA=;
 b=PSOLCM4QUOwMwyWZ2r2asLqO+w46IUD/ZkOTSdZq+nICSQr90b1TIPmdQJwALLE4M8ZHa2pOl1tFAQfFCD5jfzlrP5GCuWyRdCteoCicvROb0D6XZqEUvJWGqBZSEnsxu3PICHqXgfazMMFDg6JC7YtpyvTOyrmPHk0ywdVFKLg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 13:56:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 13:56:29 +0000
Message-ID: <17355f27-f631-4bf5-896b-f846f6b05ad8@oracle.com>
Date: Thu, 21 Dec 2023 13:56:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
References: <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
 <20231221121925.GB17956@lst.de>
 <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com>
 <20231221125713.GA24013@lst.de>
 <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com>
 <20231221132236.GB26817@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231221132236.GB26817@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0138.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 024fcf38-391e-4f9f-653b-08dc022c961f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TzVJU+UyBUy0BDaN4cJmKIBjoFKEN4OZmVXM5Rm0qZ4TFsoX8TvF/kPD1WJ1lYXldyBs4/9FqdtMMrtgv0VqE9AH0IRKqzGnjZ70okzvnrw2gJ3i359AE4XvMdc/vKiCNpsmtFruLTnWsB3Rq1z9gnEky7NMqFbIBamAHsyjvLxeA/xBY305Ivbr3L1Ioyc+LVQesCdN5QMq/bGbYIMMBbaXwcNHOZmFpMws7S372QWmU6HQ1cRop+KOqThjvlGvS4IAI3ZbhoeFKZFW5nOPfjt33fzSUTPqgaa32uUA9VBdkWuliJU58ShW0+U6KqA5e6hdd4KlDMfQ9zE1GGR0s2Iby+7yAY5J0JKnW6JyHgZ4DwwwS7I187DYf+RwThgeA0lrUIxd21SBNnzKEDHQ7/oyVyvwV5zN3pG6HeQqnMCO/+4p3qnlxl4NJJksXwphVDODw+p/f5wKjX3PXIIEvCU1N3WnkVSffFcNOaOd9IgrlZ+i/K7BiHTClKBpNxvCcBsUVqBCtJ2GCT0KE+MfyEQpXVUfVAAsZIXGhjiFLaG9T/NlvHx03EsqXFeY1dArNOq0/Efh6hYtiDSPX6/2cVLd09njSjXtBOn9sgtIaIIK5h1qAUeLiCKkXDsUkr2l+y8EtmbS6p2PmF6PIiDH/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6512007)(2616005)(53546011)(36916002)(6506007)(83380400001)(26005)(86362001)(4326008)(8936002)(36756003)(2906002)(31696002)(8676002)(4744005)(5660300002)(41300700001)(7416002)(6916009)(66476007)(66556008)(316002)(66946007)(6666004)(478600001)(6486002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3M2akZ4cktnYmV6dkU3MjJrdFJHV2ltMERFRDF1RkVPMmpuZTJjTERLdEJ5?=
 =?utf-8?B?ajVXbFBLSDFMZzRDY29oUWx3b2U0bTd4MzB1dFlLK0JabVhkdFRsNHRTQU1y?=
 =?utf-8?B?OVlXZGc5M0lIZTA2cjU3RGQ4WFlSSFRPN3FVZWNjTy8xNWxhc3ZyV1ZESlJQ?=
 =?utf-8?B?OTV6bDUyYlRyVW1UQVBIK1kxZDhTdkpocVp2bzRGQ21ta0EzRXZ6Nmd0MWh1?=
 =?utf-8?B?WjV2SWtQMkczT3RBMzk3cVhUN2swMXRqZS95bEQxZDd4eGl2dVVoa3U4bGxV?=
 =?utf-8?B?b3pLbEZJcnRyTkp0SlNPa2pQUW0zcUtCdnM1ZVRjOUwzRGwxSXNycWx1Zkhm?=
 =?utf-8?B?QTRYVm9WeSsxN2ZGQzRtNFFVa3J6TDhzTzJJb2IvWUFKUHNjMi9rUVJhV1Fl?=
 =?utf-8?B?SHFhWEtISjdZeFFzbHpvelFPSkdDK09NTjd4bFhOeHBVeDl5ck9ZZE55RzVD?=
 =?utf-8?B?dlZXa0FmaEkzNXRwVUpUbFdDWWpIcHNjMFlTK1VyUmpsVUdxVEJMU0FNS0M1?=
 =?utf-8?B?Uk1nMUZLendVaklodVl0bUlmejFwdHEzZkZqWko3YkNsSCtjYXV0aTlyQTd2?=
 =?utf-8?B?eTA3RDRYTXNDRTlqczJZdmRESUhsaTMvbjNFK1lUWjJtOXNiaW5EUTl0YXJm?=
 =?utf-8?B?YUNzQXhBbm42TUJRcEtVWnNwRnVNSXpxNFE4aXFtR2xBbVczMUZlQjhBZjg2?=
 =?utf-8?B?VW9COEYvQjRQR2VOQ2t6VVBnelB0ZDlNUlpiOWF1MzY0aXl1MUdZMW00djRu?=
 =?utf-8?B?bTdPSWZFc3RnMktEVEg3UTJPYUtCMnRMODEzdmFGcUxxZmFwM1Zlc0NIdm5M?=
 =?utf-8?B?VnZNUE1VU3ZzWkl1cE0zWWtjS05EZWN0MS9JNk12ZGFjWUplVVVJUklFd1NI?=
 =?utf-8?B?Z1hqUEx5TDhxdlBqWEJiZTRzZ093QkRFLzNoQ3htTnMwWU9MOFRrbDBGRnZV?=
 =?utf-8?B?RENzVkRqa1V5b1JETktXOVZXTjJSeE1YMm5rSzdTWkowVk51ZHQ4M21RNHhi?=
 =?utf-8?B?bURsaUFNYnN1TCtrUzFPaFNIYkZOSG9MYUJMckNRNTU2b3M5cVZKOEh1ZE5N?=
 =?utf-8?B?UVZGSFFMb1E3U3psT2I3UlpSWmJQRzZwREZmWVQ4bUh3WGVCbzBUUk9oTjAw?=
 =?utf-8?B?NUZCVTJmZVZtdm55VkExVW9TMXo0Y2FvVjJ0R2JqdWlQNlJsT0REVzZaTk9S?=
 =?utf-8?B?K3lBR1JHVWNtN0pseEk0WlNqNnhiNmhEcldQcFREREtDV2xsYzZSRGZVMWEx?=
 =?utf-8?B?cUp6UEtEVDFqVTBzaWdHdnpBQ2NnSkl2NENKU0xHOVZqLzdXVWVRcytUdEdm?=
 =?utf-8?B?VHBxbWN2cGIzZDVjTkZCN1QrVjJPU1NUMmJHSzhpai95Mi9PVHgrZEN3TW1R?=
 =?utf-8?B?RVV6Y3R2V09lM3BjZVpXdUNweGdCdkVWYkUvMzBOTGtnYjhVR1FGdlVKWld2?=
 =?utf-8?B?QUdBeVdNcWxIeU9UbXE3dHJOdk9WazdrbVNTS3F1M3pRaFRPTmt0OFU5MGI5?=
 =?utf-8?B?QnppRXVmSS9HNHdVTFF4ekN6b0FQdHFrUDYrWlBuNGZ0YXdyODJtSk9uOFFW?=
 =?utf-8?B?SjFWOXBiUlNxaDdrRytrcXhDMHQvRmM1WkVYR05YdFk0TXhqZW8wTUZlcEFs?=
 =?utf-8?B?T0I1SHo0bnlOZjBmbGRuRDFDRk5JalJQVmxaUXdTa3VQYkZpVmY4VFVJL2dH?=
 =?utf-8?B?dVJkUzY2RnFhZFRHSmQxK1IyWFp4cFhyeFE3NGNjcEkzOHZsN0xaelhESzBt?=
 =?utf-8?B?K1RpbE5JaEVoSm5vaXViU0t6VFc4Z2Y5RnJ1THAyLzZ0UnZ1dHozdGlPWVNP?=
 =?utf-8?B?Zm5XNFdQQWluWXZ0NDJkMU5BL1JaaEN2Nzc5VUJrL213QkdmeitDOFBtMmRB?=
 =?utf-8?B?UEtpSU83eEI5WmZNa0tMRTZEdExvcWppRlczV3lXWkVBaGg3Zjdta3hrYytK?=
 =?utf-8?B?cEtGWFJIbjY2RnVPd1RCOWpndlc2TkNLT0U2ZGRYRDgvVXlhZTdTc04zdUxm?=
 =?utf-8?B?YTlzTndoWFJKOFgrS09jaHM1RzRjenhnQTF1VEErck5yUWJhT1RZK2JPNW9G?=
 =?utf-8?B?WGozaWI3Z0p1dGlhZ1N3d1h6M0NoRWNlOVdldFFraThrTHNxSGp2eWRWYVFR?=
 =?utf-8?B?Q0RiNWVmeUY1UUFkQ0FDa2pHYVdqdlpWYUJCcWxjaFR5b1JrRzdLSVJVVkFF?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1Cd20yWfA4HnuNs8ZrPEBWvLy7C+0V4rJ6pL0Co2cFCCPxwbOa2/hKh3zb5UMxD2Ebbpn5axBiIgrxk0cBzb2ds2uivXCGbpy51gBvgML5WC0yqnl+JBnsAqzkM0RT/nKjwxXPxsd8JhyVMZQ2gn0UA4L52atehOMQEApUWEzy9ksjJ+lX9QYiqIwMrtW6c87Ik1wjnZAgvKDknkaaVXa/lqDxTQ8DCQ1O40ATKQSJgoClr1N6LDTI1hgftatqQSfHSaMQGc56pSyfvmPRofmPkfarOnEVsAd9Uewkepjm4NgqpwNNhU4T+cYlNfe2jVkyUe93DD/IUoL7HWzCSeT6EQQ1lDio0IdNblx3UJGGw6Mz8soiFUlZMtFLNZt9tTMxBEg0F04t+xSol0AYPUi0DqInZIVwb9AYBwayPTEomJwpQgl6xgFdLtalfGW7hfaR5qbM17m+pyfGhoVUnRs8x0ZtZ13L9VwW+KKTyYMMg5nvha8gAI/RhV8E/B8bj8lxJRj+TVSpys69ZVy46u2GDSq/C/oMZuFaabhWmgLtuc50e63Ocxv4uT3vZKmE2/ze++q6ZEzCjChOilOjFP3bu6eWho1TLVxSI0wW1Eh8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024fcf38-391e-4f9f-653b-08dc022c961f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:56:10.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3NYzR4mcnGB6eYaRoVDrg6qNGm2TQ/KUOEd0CGE1ILRJsmj9upTxvzjjy7nEVakdo0z+zvo8mD7csuwM6TifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_07,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210105
X-Proofpoint-GUID: sYssheEln8wRvAqO0ccjoKdgqaN4zgfJ
X-Proofpoint-ORIG-GUID: sYssheEln8wRvAqO0ccjoKdgqaN4zgfJ

On 21/12/2023 13:22, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 01:18:33PM +0000, John Garry wrote:
>>> For SGL-capable devices that would be
>>> BIO_MAX_VECS, otherwise 1.
>>
>> ok, but we would need to advertise that or whatever segment limit. A statx
>> field just for that seems a bit inefficient in terms of space.
> 
> I'd rather not hard code BIO_MAX_VECS in the ABI,

For sure

> which suggest we
> want to export is as a field. 

ok

> Network file systems also might have
> their own limits for one reason or another.

Understood

