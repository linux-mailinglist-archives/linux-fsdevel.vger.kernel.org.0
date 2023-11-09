Return-Path: <linux-fsdevel+bounces-2628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357167E71F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 20:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579D71C20C5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6999A347B0;
	Thu,  9 Nov 2023 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3Dyp22wp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UY7odCo1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD92E32182;
	Thu,  9 Nov 2023 19:09:22 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6079030EB;
	Thu,  9 Nov 2023 11:09:22 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9IJibV023778;
	Thu, 9 Nov 2023 19:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mcD54wNiWFRJgu00WvJOQa0GwVIyLgFyLvvYy1c5IgU=;
 b=3Dyp22wpCHxcKYaG5xwVtOlAYSdcLEc7ydSYDQEek+yWkZ4/SSDC9FKqQ0xQMwrSfasZ
 fN+aCLl0IDc7iwJqjTGrrahNgKPNbrekjSRq+Ml9qXEaZXoCHyhiklw3Zl8lRubbOZwC
 /0oM2I2o9TrOGX8rpPdr+0AOuDar2d50sPztEebYqAOFjjqPVac6TNmf63ACZ9M2jGG7
 H896RtC7xoNkboMyv/1+gotB2rtY6nb3OCsag5zRSCNkGYVN1qj4qRmOcXKLX4Dkf8vC
 0obhyYJAbYqv6sR+6g4nS8IW8tEE0NJ4GrwXNUl4ioukE29JAxyaq9LNCSDP+2sL5PmV zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23mrdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 19:08:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9J737V000483;
	Thu, 9 Nov 2023 19:08:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1yd56r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 19:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeM/venL54ig4i17J2eAB9j+VrAhsV9/e5WGc2fLtwYDgabxu6O4ON1BFLq4QAu9ypubg7hAMDMCvCtaKfKZtUeHL6LN4nR6XogG2diRqUvjka9M8sQsx3qS1qYJMcEwctKRWhNf/wTiHN2uqZjhqEO5FXBuWkKHmTGdYSXkfXHkvdACONOgGd11Swgxy0+Wcbjy799LW+g+JcVkbGSXYYI8veRmlcQtObNjXEI7Y/x+4wTHAkJEz94Xr+G2XuZiBXa/3oQTKEZMzMrOXOlfo/Q5OxS5xuQMdon1+IeDyZGfqZq9MRqoB16b6slANj/tAly7zZE5JI+bwHqwQhQZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcD54wNiWFRJgu00WvJOQa0GwVIyLgFyLvvYy1c5IgU=;
 b=ANqTnJfuXlVWLFv01tAHT09A4l9BSkEvoyhwvoo+FEr/DsM47tBw1CfcmLI1M/y9AievHsO3QnrJo9NEweMFJ21otPRsjLx3AhOz5JkFbTmuwb/Ln0GvFcLHviy8GPurfOB3tIi6s0ao1EK7VgmEJ/WtDE7437dmj8O1KiTjKFbRNBxnSeS8bogMKdmZYNCDnghnI6LX4jH7tobONeLj2U3YOXAvFcXjmmEiCaEzcel0r5v5zUzygtexWiKw8emxBCfXyf2cLZgsmpD9exeFTK0UzeehMxXDW1SX3IuefAZn2OV0UceuQpF1ZySABfAT0G4m8Gy66jTj1rw6sK1aOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcD54wNiWFRJgu00WvJOQa0GwVIyLgFyLvvYy1c5IgU=;
 b=UY7odCo1ZAPo1eR4Orkw8vPLzAHr3z+QcugMHUrAN47TC8CMigG2PwXWQl0MMCyTWpapa2O+k0RcrRd8MVIKIHytf8yn6tw8UkiMqi4aHB5axtiWC6iliV7nEI0zfV3gRzvmNh0tq3T+T4rs3viZi5L97ZTW82ujZwrLyqL0P/Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7222.namprd10.prod.outlook.com (2603:10b6:8:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 19:08:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 19:08:46 +0000
Message-ID: <61b25fe8-22ae-c299-3225-ca835b337d41@oracle.com>
Date: Thu, 9 Nov 2023 19:08:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-22-john.g.garry@oracle.com>
 <20231109153603.GA2188@lst.de> <ZUz98KriiLsM8oQd@casper.infradead.org>
 <20231109154619.GA3491@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231109154619.GA3491@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: a41e7a82-a6a9-4fe1-461b-08dbe1574c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/Mlb+vU/EI2C97dWMECVgw/vek25ADxnn/vS4ZP1EnW8cxde/EkWdmrY5r2IumdKLqWvEVk67YZJkMFFER2N5rCyW8DGoFYpT1QT0bopGVyWUqDY8VfeRFHVhml3crkDq9LWBiLehtT/Wpcfk4O5N6n7wddLU4l85BPLRRYBUFaij9/ObSJEjaaXORQOX6sQF746cRt0y6WyXFUHVm1sIiZ2uIGZ01Ggk4YQDFYhQmYfBfm6L0qjddCGVt9vDBbTXMIBQzIgYFQn4MiPQ84a/cxIG3b6i9/rqdvdm3nha4R8ERvNp9B7gCbm8/wrjJn4tp4jkTVwtAQg6+rEmiXb+f0cJ/VnIRGJAHXWQYqn+W/SLsqoByLu80V5O4fCMfr+StCYgpYTFIdwb9FwWc6Q9isQRrksn4t/+6AV37X02ZGpCI56dgCa+836w6tPwUPokhyu6ZBoiVveuQVBEVEOegzcdeY2hxmb/WZlVXzT6SFQSXK8aalM0xCoHcOSHUkuEvdMwj4djn5XOZayfmQ80nDOSd64LikaPwf+7ZirH6p4epSM94yzv/fPX0uGtahoNc+FNogqgE6hE8iaSt/6tjG/UN6VCH52ZhUudiw3+M7xFF9qJHcFJSLnGvYScVcCKLErVdVi8fX4oXWoz9rFLw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6512007)(36916002)(53546011)(478600001)(107886003)(6486002)(6666004)(6506007)(2616005)(36756003)(38100700002)(86362001)(31696002)(66476007)(66946007)(66556008)(41300700001)(83380400001)(2906002)(7416002)(26005)(5660300002)(316002)(4326008)(110136005)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWhjQzBOWXdDOWg4RFFkRDNORFB6cmdCWlEyQmU5OTVuc0NOTEYzWUxuOEhB?=
 =?utf-8?B?Q0pJWGNXKzZzZnNNYTcwWnl3QW1SemEyTjluUXk3b2xnYWtCbndQNVJra3NC?=
 =?utf-8?B?Y1h4TVhSZlFURDVpTkRQVmlnQ09yS2huQ3RoY0ZzR2RzUGFkU2tUTlA2aDFh?=
 =?utf-8?B?SU9ZUVZlOUwxU3VHczQzVDdCQkx3S3ZUdUdESFVPcHNqVnBKWE5XbS9zSGJM?=
 =?utf-8?B?SklHUHo1RkVzL2xQam5naER1SGFpOGpNVS8xdE9LNjU1RjhHeXlZaDZ0dFdO?=
 =?utf-8?B?ZVJ2TFpQY055UUNuY2h3VU4ySXVUNktkWGV1Wm1BWDRzd2VWcFBhdkxkYXpk?=
 =?utf-8?B?a2t6NTQrZUwwK3YzT2ZmdFkvb2RYNlNzL2kvNkxtLzkycERXUGZUZGdOVjZX?=
 =?utf-8?B?eTN4Nno5OFBoa214WmdzRWcybFdHNmZhYldMblI2L1dJSUVSV1M2THR1ajdR?=
 =?utf-8?B?SE5ZN2ZqODhhbzY0WnI4cjRHOEMzL2JRem42Y1BrVHJ0OVZTSjk2T0pHajVT?=
 =?utf-8?B?Q2dtMGxkRjRQaEhwSW1xNUtzNzcwS2NZRmFzbVFCc01IS2FGdEN3VUx3Z3ZY?=
 =?utf-8?B?bVN3ay9MV1M3QStMajFmMmk2WC9CODVnYjRqSGpsbDVNWUlocDBZZlBXeWdT?=
 =?utf-8?B?TUFBMWY3dTFGK2tCOWVqWk9PYVhCZHprNHN1ZmcrSHdKVXNtdWl5bVNuM3h6?=
 =?utf-8?B?SkZZckZpNEdiOXJYRmNZOWFpdm5zVi9LcldUclpvMFpqNFVwblRwNEs4eEZs?=
 =?utf-8?B?bjV4TTJPeTFja3N2NmYyMWlLMHRBcFF4SEFnRTFxaEZ5VVlDU3VVR2kyR3Yw?=
 =?utf-8?B?cFFnczJXeVUwRmhNMlY0Uk5HUFVTT2thbTFDRjBDUW94eCtXd1NCd0l6UWsy?=
 =?utf-8?B?SjJRenB5UHhtTmdaZTdmN2dLQWg2MmtZSHJWMWZvZkwrTEJuc0Z5QTlWcHVr?=
 =?utf-8?B?d1Z0M0tEQXNPeVpEWkxmd2JpL2JDYlIycHBQK2hEUmpjN3o1QXBYN1dCcjlv?=
 =?utf-8?B?WkNoMVoxZkk1UE5wV3Fia3JSNlhQc1hzam94eXNxdXc4c3VPWTh5dDBXTmE0?=
 =?utf-8?B?U2Q1Znk5Mlg5OVFIU2xFMUFFRnR0SWJ3Z251UXNGYTlHNDJvam8vajkzU05I?=
 =?utf-8?B?RENiZFpubDE0R0NVL3ZVNnFCU1dEM2prQW1yYm8wcTFuQzdXbm5Pc3pLbTZF?=
 =?utf-8?B?SGdlUWJyQzVYTFNJbW9BNUdQTnVDdXpQN2VIUUkzTUNxN0JnZ2FTWXJjWVVU?=
 =?utf-8?B?dnhkZDBCZjlycTh3bFBEU2N2NjJlbGltM1VBU2NxTTV3SldGWDBXSDZRZDNv?=
 =?utf-8?B?SlhjZlhrdmFpMVpXUUgwTFpTNS9VSTVmZVR1akVhWEd6ckQrVUJiUW8zeWxh?=
 =?utf-8?B?emtrL3pGUGJRMTNyaFpSb0RvdWF6SFlEdHgvV1FtRkZHRnpidmVEa0hpQTlr?=
 =?utf-8?B?b08wRFNidUhNUVR2WW1pM0t2eWpQczladk8xV1VlckxUWTRabTN5SXBabmR3?=
 =?utf-8?B?QVYyU3NNckQ5ajJ4MWhmTFVoRjdqbVd2V0JJUnVrWVp1WmdHMjAwQU42U2FF?=
 =?utf-8?B?NzZnV2JBaU53QW5mRXNBMFlUaUtWTWtSeGNpUUtnYU9pWFppeGpqTVNkQVFp?=
 =?utf-8?B?SHJUeFg0eGFwYy9rVFUxWDIxTWd4VHJrNTdWSi9INVhJem1hdUpnYkVpdGRp?=
 =?utf-8?B?QktFS0VIc1JyUEcwVlQraVdOQ3RjQVZMZkJ0SGl0cFUzdWVRSTRxMU9ZdjRT?=
 =?utf-8?B?SE1vVFNnS3dwVEVGbWlrRldaTFR5SUFLd1R1VkgwNUgwS0l1RHV1c1ZnQlRh?=
 =?utf-8?B?UkNjY2g2Y29Bc1NXZTJGMTJDaVV6Umdac05YUUkvQ1FpVVNEalpObVJ4bEZT?=
 =?utf-8?B?UWFkL0NUaWFPU1NlYlh0VE5NcE0yaVMwR3hqY2cxWGxCMUoxVCtUZGpwSDNI?=
 =?utf-8?B?QjZzOTd2VVNzbXBHNnI4czNiWHJ6bUlaVVhrWjNIZ3FOUjhMMEc0NFJUVjF5?=
 =?utf-8?B?TDN5VndvdkJWZ1lWSmYrVHh3Qld1eWs0S0p6LzJpWklTOFlNM2U0SmVTN1Yy?=
 =?utf-8?B?NEpmRU1Ec0lPVzlhMUpqZ2lscVVRYTZNMWZhN1FhaXhqVUFkbWljc2E4eFp4?=
 =?utf-8?Q?9s3HCQQCRWxgzr3VTfXffKbK/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?ZW9HWGdDNHZQZk9Md05ONHhSWXR5a0JDNVoyNUU3M1ZibFdROGJYcEg3NnFG?=
 =?utf-8?B?eWhldWNwemFteFc4Q2w5VWRBTlh2VkMwTE1KckFRcXBGSG8yVGh2R3lFTWJE?=
 =?utf-8?B?OVpJd0NHcWhtRjU1YlFIVUlMUU5NQ3doa2VvV2Z4R2FHeFVCM0VIbmc4ZEN6?=
 =?utf-8?B?Q014eFg2enluemVIc0VzUTV0QUlUUkQybmZyVWRoTUd3UXlaWkFMVkFkYzBi?=
 =?utf-8?B?OXFTYzVqRWJ0UWU0MXV1WUFiclQrVWdVMTZZZmFSTzZlNnBIRGd2QVJYWksy?=
 =?utf-8?B?QmVnWURvc0NvU3UvcWI4S21QSENqSnBtSDRjeEJLcXJyeWpocUNiWnViNmFz?=
 =?utf-8?B?Z281b3VlZGZ3dUxMTmxSVEhFVldEVk1vNXJQeEdSNzJZejFTUUZFSUlYN2dF?=
 =?utf-8?B?QXh6ejdENWltaDRWZ1N2cmJhdGtqOXNkWWpRdm0xSTA2czd6U0pocW1nWnp3?=
 =?utf-8?B?akQvVUpRSnJ2SDJFQ0ZtY21pVk0yUVVZdWNPc21xOVd0QTNHMC8zNmdrbWtX?=
 =?utf-8?B?cnBoaTZyZG5WbGZyUnVvRDJiWnJ6M0FkdVJkSUlTdGliOHZTRENRaHRPSWhM?=
 =?utf-8?B?SDFuNzc1RGhjcE5Balkva0NDaEFPOElpM0FVTzF2QTJvblJ2MUZKMk5lZGRn?=
 =?utf-8?B?QXlBVStPQThMVmxaRGNBRVFGdGsxU3hvT1YyN2VyenVjM3JPWFp4eWVlMWh6?=
 =?utf-8?B?L21sU3dLM3VqT3VMWGJ0NVc4a2wzaURVaDdKLzFKc2pUdUpiWVIrUkM2UWow?=
 =?utf-8?B?b0Zna2IyVnVDendWNGNEOU5ScnoxTzZjUW15QzVBQTZNcVkwSjloSWNCQWIw?=
 =?utf-8?B?Z1hqWGNoWEl3RUptelJYcW1oWWlOcXFTNkV2TTlUdUltVTNsMjJxZmRBaFJm?=
 =?utf-8?B?MFk2K3VwVXNZMHN2MS9pYTk0U3E5TTk0VnhMeXhOV0V2cFpkaERwSWFGNnR5?=
 =?utf-8?B?YTNRVTB0S3U0Sml2akUxZ1JlRVBtd05qWGpWcXF4MUdwd2M5V1VSanMyRXRa?=
 =?utf-8?B?MnRReWdyK0h5TWNjdW9kUHcvYU04emR1VEtnR1A2b1FpcENzUmN3SXZiT1Zz?=
 =?utf-8?B?ZUNaZkRabXZRcFZYamR1OERvR0lyc2czS2xpTVhIZk9iajE3SkQ1NTM1cTNm?=
 =?utf-8?B?cnBITXlmREtsVE5qTkFXRzJ6SUNrN0h0N1pnM0tOVmV3NWk1T1V2QWhwUVIy?=
 =?utf-8?B?NUJ5OCtOdU4ralpSaGJ4RnZaZlU3bTZhSm5rMktVK3p4RVg0QXh0OXIwZ3F5?=
 =?utf-8?B?dHBDM0hoOW0xajdPZkZILys4TWZJeGc4eEJQRnlGb01lT3RXWmc4QkZYVi9P?=
 =?utf-8?B?ZVZjc1RaTlhOTVlOQ1ZWMEptWXYwcHZseHpaU1dWclc2ZGxGTFkzY1F4bHN0?=
 =?utf-8?B?TU1MbG00bm85ZHJQMC8xcEZGdm0zODc3VWNDWjhVWUFJWmpVc2FhYVZRRG9G?=
 =?utf-8?B?UXVYU1ExbForbjdBTk9LSmVYbnNWTS9WUmMxbzFLM2FzYnhuMGRDeGJBSWtu?=
 =?utf-8?Q?ewoFbm71Oa2UVnbNwjFtqX+Pe5l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41e7a82-a6a9-4fe1-461b-08dbe1574c69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 19:08:46.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+/TQiZpBtwZWs8seapxlYDvFt8REb0ViKa18+hOxY0LOe5IJZnEe5XC6rRphdb3CLOLha8swILHS8M933l4NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090138
X-Proofpoint-GUID: Du6umTe3sbVUQQ43zgYGKI-3_BMVcZBr
X-Proofpoint-ORIG-GUID: Du6umTe3sbVUQQ43zgYGKI-3_BMVcZBr

On 09/11/2023 15:46, Christoph Hellwig wrote:
> On Thu, Nov 09, 2023 at 03:42:40PM +0000, Matthew Wilcox wrote:
>> That wasn't the model we had in mind.  In our thinking, it was fine to
>> send a write that crossed the atomic write limit, but the drive wouldn't
>> guarantee that it was atomic except at the atomic write boundary.
>> Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
>> into a single 80kB write, and if the power failed midway through, the
>> drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
>> all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
>> 64-80kB and not the other three.

I didn't think that there are any atomic write guarantees at all if we 
ever exceed AWUN or AWUPF or cross the atomic write boundary (if any).

> I can see some use for that, but I'm really worried that debugging
> problems in the I/O merging and splitting will be absolute hell.

Even if bios were merged for NVMe the total request length still should 
not exceed AWUPF. However a check can be added to ensure this for a 
submitted atomic write request.

As for splitting, it is not permitted for atomic writes and only a 
single bio is permitted to be created per write. Are more integrity 
checks required?

Thanks,
John

