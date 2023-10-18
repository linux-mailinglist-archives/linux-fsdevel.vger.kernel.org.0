Return-Path: <linux-fsdevel+bounces-667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2223C7CE153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451961C20D25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331B3B288;
	Wed, 18 Oct 2023 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MVc8Fcbs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qe5mnqcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3771A278
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:37:12 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04B114;
	Wed, 18 Oct 2023 08:37:11 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IFTZSX016744;
	Wed, 18 Oct 2023 15:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=CJfYMInr/K1hy3IU2aWqf9zeMrpDG5MY0RM9eyosDFA=;
 b=MVc8FcbsVh7q1grN8L27WUBmYYyaLwkUbPWdG8hDFeZ08wtAxXxq0uqurLkM/AWrB+Xw
 MfCYYZM2S4mVs7R1yzYo9OVq1ra+xK4GwlbiV1TnxLEGqSpF+TFkWoDcOacVABFFKklq
 jSgLZX96EKVlO9TT55n/9cReHU2UJ8Wrj2+i5LQRT2PEVh84OCfoFcz7AcruP0nRJlUW
 fkB27MtQWgw2UepKlGlS3ZVYGOBonAZS9uN8wIX/3WzAP/i3XQ1PRVjDexAWv7ofhhXn
 pVanXOPinjTMiED3IpOwJh3w6S8tr/HPZ6wm3bfXW9LOmZS6fm+TnmWjXYcKwMOr79Xl qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28qyjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 15:36:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IFCgZt027148;
	Wed, 18 Oct 2023 15:36:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg55fdka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 15:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuQ6ufOE8hO/VLAzypSSOeN6xsSa4DkqPSMmKg+t2hDRZTypMKk5jXcrCObYPMO+6J20PGEwnP9qwu4PpkaNu3OPbE2XJLz3zxn10Ib86py7IQCYie+YQxrQfhTlcupLuUQK3NLZq+UeZS5w63eIq0CE5GohODSPkqt0RYouozVvaOTP/dlAZYwSzQzN137xdiVUzG076vFMCUO2z9yZN59JupC+KX8/qJ5uct5AevpqXuc6Wtdu6gvkNeygkLGY4nEunQucOOD4Tl9ABBfimictlrzdyAJgnuXolmBYtJq0ihLAB8NdloSNSu0klb9wtHkw2RhYVHnqsRksSoyf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJfYMInr/K1hy3IU2aWqf9zeMrpDG5MY0RM9eyosDFA=;
 b=HcCr8k4cMPbxM8ENPf1CS1ZzYjgTHuywqwSpoZuloMGzyVHWrRvky/GSdv75frOChvfs6BcCv964TTaRZnT2Vr+NtZfi2BLtUHryHKHFqnEBnu8Qs7fglU/t/XlQYQGzkrDq8+zC5vafRZiYI/qTw8jcCdv4DFzQtRGLWYJcU3C7NxAmNrUlEdyG88QPSfopdqV6DNeIaU193NolJSVqSGmrLyfd7Oaw0uA5djh3hA1qMtHhDRiTFKA997GDhkFVBwqtT2q9/+goDhU5nNcmLKM1Wb49IujTWY3aEKzHCnGHGPdWcaTiB484IgzLWjCEIViFurVAaTmefIOeDqjviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJfYMInr/K1hy3IU2aWqf9zeMrpDG5MY0RM9eyosDFA=;
 b=Qe5mnqcMjBmA29w780Hx2yKoX3gkXrDxpGb2lMc/nrrHa4xWKV7Ji+Whg/rKjuiTRryIMq/t9spKJTlqjoRRz7gIBK3mBRfTQG/HlGSIYpo4TobeQi30JWbCJsZZ98VZ2HSEVcXWLRPZxZWRfNMa7UYwnQ6lxAl6jx0zmgB4ErM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7534.namprd10.prod.outlook.com (2603:10b6:610:190::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Wed, 18 Oct
 2023 15:36:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 15:36:33 +0000
Date: Wed, 18 Oct 2023 11:36:29 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Steve French <sfrench@samba.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for
 NFS export
Message-ID: <ZS/7fQWxuwaUIt/O@tissot.1015granger.net>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-4-amir73il@gmail.com>
 <ZS/3UfX/+hH6xKMn@tissot.1015granger.net>
 <CAOQ4uxj4CQmVKvmLg0UdNJWZ14Dp6SjJUvwqFdO3u9--M4dH6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj4CQmVKvmLg0UdNJWZ14Dp6SjJUvwqFdO3u9--M4dH6g@mail.gmail.com>
X-ClientProxiedBy: CH5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c90037-ccc0-4708-1a1b-08dbcff001a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jL01N2kAtDQs/5crydWqdRATy6TtUqX1RIgWyM4bseRfBRbEzf+TtNzd3zJRYGDOgaL83D/nB+X3Y4q2LrBaQ0xJBHpoujzIE55hRnLNw8AHyftH9pvPvAJP/3SGOBvUGwjCOQcA5SYRH0fm9ngyZyqOAU6WmLnS2uTYgCe3eNt5bpjAoEefM1yRW+tLkCnp2NMW1iDPgfE/zFm2rMOwCINwjaInAyqxi7nrDN8EMhMnvBPGfN/oUXkLetCXHELxWGPPiWvrj5PL8iWAuWqwPyNmUG2f0I9ggbHhC+0s9MjLK+mGfX88c/6Lk73d9vl3NA+M6kyl44f/JTUTc3gRoKISccctOnlbTMYdLD2A8JfGUV7uZHYGoi+3Gu5R6l3isrG5PZVnTxFoMlJAI/4nPXZc2g3q3LUUi73+1Q6aGTGlmZQfGOgZEjJBM4QFel7+0/px9aF5082No2RN3PKoz1SlYpurZ2WiMSoRMIbo2SEVKwrjRgz2s9LuZ2iW9NrwfmAcQPgABa1CuHHzPgTwBbCQ3rTMk5rOkQAFYN6V+eFrmu6HZfTvqf04Q4cJOUm4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(53546011)(66946007)(9686003)(4326008)(8936002)(6916009)(316002)(6666004)(66476007)(6512007)(6506007)(66556008)(54906003)(38100700002)(5660300002)(8676002)(44832011)(26005)(478600001)(6486002)(41300700001)(2906002)(83380400001)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTFYc1luYmZmb096bEtob3FlRFFud2MycTZGcndFYmdodW5KY1RkSTZVNWF6?=
 =?utf-8?B?dnVyOGRDZTJoblA4eFRlRTVPU0paZkVoa1doYkkwbVFLcGtqMHFkSDJOQjk4?=
 =?utf-8?B?U3F0RW40MG9WbFpBMG9POTBFTjRCZDZ2bkdUTDU2NWJjOGZZVUdOMmtOOHlh?=
 =?utf-8?B?QXoyMW1RSFU1MGozQTBvcmtvcUEyaElkOTE0cGFvTDlnQUhqRUFaMG9oK2lz?=
 =?utf-8?B?OS9xYm9vREZRNEpFbEFPUEFKZWJlaU00MGsrR3UzRzJ1Z1pjclJmOGQ0dXZk?=
 =?utf-8?B?b1JWdmFpdXVkWExEWWU2dkhseENSR0JwRkVZeW94R04rSFpyVEJuRkVDSnIv?=
 =?utf-8?B?TXF4OVQ0K0lTZWxxVng4d0dnbE9VSVhNblphUWN4dXRkdU1hV0Y2emdVRHJ5?=
 =?utf-8?B?bjYzb3d2czBCeUJOZldHSU5EY1hKQVZoc0dSNENIbXExZlZxOXhrczBtbkp5?=
 =?utf-8?B?VGwrZHQ5a2ZYcXhEb0ROSWxiL0pERzZKR1U1UkNIU0IvSGVMQnA5b2FwYmZ1?=
 =?utf-8?B?TWRqQjJ0OG1aUHhoSzVDb21UR2RRQ3FUZW1GMHY5YmdQeHYzaTVYUEJOL1pI?=
 =?utf-8?B?SzQvcmJEbnF5TWpUOENaQW1rODJNclVUSG1GSDRYVVFpandtL3VrRVBXeWI0?=
 =?utf-8?B?UUhOUENoME1GV2JXOUVyZGpwdHZ3SVRTNWQvV1BZVzBOYzI0eFk4dUpTZW13?=
 =?utf-8?B?MVpxYWdtZGZtYnNSdmtDL1BqYkt4NlFESHdtRjF3dnFWTXhoWGtEU3JrRHVL?=
 =?utf-8?B?LzNwMlp6VmFSQ0ZQSEcxRlVpVUpLQ09pUnA1M0RIWHJhcXBKRjNEUk1Wdnpa?=
 =?utf-8?B?ZlhPckNmZlQ0KzEvUGdSNW4rTFJHTGtFUmROZFlFQldPbWJOZ1dMUFFrQlMx?=
 =?utf-8?B?MUtZbjcxLzl2VWZHUkg0QjlKcGVMeHQzWU5adFVMS0RxbjcwOW0rWThBYTdv?=
 =?utf-8?B?bVl1VG1OaDBDNUpRTWhjMmVKWkprUHlHaVZ1UFBhTkZPS3FIREV1WU9ZQ05D?=
 =?utf-8?B?UEVuaFc4NC9VV04vNitzZW9BT3pEL05rZ05UL0tOSTNTblo1ZWxzbFBFY2VW?=
 =?utf-8?B?YVVGUjhrdmlacm9FVjBvZ3V1SFpPbUR5b0FFMWRQSURGcjRENkxURVVwdDhE?=
 =?utf-8?B?LzZ5M1czL3pwK2llcDY1QmRMVS9VWU9TY0NFOUZvQ2dxeVFBN0QwNmVZRXZz?=
 =?utf-8?B?UU5ORGVaMml0UUU5MkNNc2hqdkIrcXR4TE5Dd2ZaM0tpbEZKeEZCbDFsakhl?=
 =?utf-8?B?UmU2WnFpbjQ0eXNvYTJjU3RLM2dkWC9IdzRrT2NEVndBMWo1M3haUlRUOUZu?=
 =?utf-8?B?VS9icW5DK01VVVdUbytSYnljQy9XU0NtTnNrL0p2UENkeUV5cjZCd1JHbzRQ?=
 =?utf-8?B?SDBpeE5ZTlg2YlkrL2FVTWZuTnd1cnhkSGFZQ2xUTmhVb0ZTNUJUY0x0SzNQ?=
 =?utf-8?B?OEpaaTlGMCtvMittN05nUTdWeFdCU0lrSVc3Kzl5S2lUL0x6cnNBVHdmc1FC?=
 =?utf-8?B?MEJuNHl0L0c3V0VWSjNCTEVOdU1FU0RodEIxcGZjVkkwOGlXWEsxVGNmRHA5?=
 =?utf-8?B?L0VOaWNpSGxWclg5NUtFT0lKL2RLR2dmRUlaMEtqVVJzRVNWaCtrQjg0eU1Y?=
 =?utf-8?B?U0EvWGdSM1VIdVNwK1RzTEwwVUlQdTRBMWJzNlhyb2JpQ3lkSk9FTGpPZDVE?=
 =?utf-8?B?bzJNalc0NytCRUVWd0lOeXplenE5WVRObmdrbHY4RVY0T09hZDRBbkV4TWs5?=
 =?utf-8?B?NlZsUkx4VnNyT3o1YVBpaUhWa2hsQmova0d1RkUyMkI5MGpXd2dwaVhkL0hk?=
 =?utf-8?B?blpNaVp4cUtPaUVOODBuaHlaV1BQSGhMTzFPTkNHM1hVenRwZ0wzWXhmNysr?=
 =?utf-8?B?VWhmK2IxN2ptV25NaDdnODVBMWFrdmRNd2NTdlZtY0ZTRHFkS2dOZXV6N0N6?=
 =?utf-8?B?SmR4S21YK3RoTFQzOFY0R0ZtWUozZTF5WC9NM21TN3NNRGsxN1V0Q3hBNExV?=
 =?utf-8?B?R1hrWVhkdERwWWR3YmR2WDFPNkxFc2ZrKzg1d281Rk1pckVGUytVdE9rZ3p1?=
 =?utf-8?B?TS9jRUZXVldPeXlDL21BRXd2WUhXNUpJcjVsRU9ZT05oeWJLYXVXWmV3ZWFB?=
 =?utf-8?B?Q0dNZFppN1ZNalk2RmtoSWhOOHdab0lxSXZJcy9YbEovUjlhMVU4cVlaeEVp?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aEg4OEhOY1lycXB0QkJIeGs5eThEU0hQWUowRWF2dFNvQXBUdVJ0Uld5aTFS?=
 =?utf-8?B?NzlmU3B6c1JlMEZTTGJqZml1cFdndEpUdUZ2RjJKOXJDczdlRzlxSzRTN3J6?=
 =?utf-8?B?VWlIaUIyK09zVWIyZGlrbGtZc1JwYk52aE5jdzJ0VUhOVjZaTCs3K25LVUYx?=
 =?utf-8?B?L3JGaGJwVU5nbkRtTTJOcldUcVZxbHJsZHRNbXlvWmJrT01ZYnNtaFNmM1B1?=
 =?utf-8?B?SUg1R2dLbkNJU1NVWWFhL2NSVXp2dDZwL2FWRHZRRW5EVW1KcSt1U2h4K2dB?=
 =?utf-8?B?cDJweVczd3pxQTFFWnBKdjYydlhKQ1VwZlZwTXlXa3h4MkhmYXNzekVqbW10?=
 =?utf-8?B?bkhVODJlMSt0NEZYanQyVUJjaWhqMmplUGVVWmRRZU1kNnlnd2JqVmh5NldF?=
 =?utf-8?B?c3hvWmswbzU0YU9Bb21nZGZjSkIxdDZPY1AvS2V0MTdMbThTV052dUpieE1o?=
 =?utf-8?B?Q3duWllOeEh1YzRzUWo3Ti96V2Fhc0hhSnlRd3kzQ0pLSm5VRHArU3NzcFZE?=
 =?utf-8?B?NHc1ZzJXQ0MrLzdEbFN0LzdtWDQ1KzNzMkoxaWpIUmVMQkxJUGlpd0MvRis2?=
 =?utf-8?B?QXd4YlhueWRGNUJZbXZhSEM1ZWpveFVCMVJFaUJSeW8ydnR3RDFPeENZT3Jt?=
 =?utf-8?B?Rm9FU2ppbTd4b0crSm1KSmhhRlpLL2ZDKzFrYkF5R2JSL3dSTGlBelFDbE1i?=
 =?utf-8?B?dlp1QlJvb1p3M1h3aVptWDdyUnFlemtRbWsvYTljNWhSYnczdUR4OWtxRnJw?=
 =?utf-8?B?TVgwRk4rMHpPUG1GanBCQ2ltMThPYnJsQ0drdEcrOHBFdHB5bWU2ZGxLbzhJ?=
 =?utf-8?B?VXpWMGx2c0VhQUJhNzBya1EwS0RVV2NtSHRqaWFiNGlCbzBHMXBwNHpSM2Vt?=
 =?utf-8?B?Smo4R1N0aVNpeUZPR215TDV6eDdZYitSOFp2elpjeHFoWEV0UW9NV2xPNVNL?=
 =?utf-8?B?ODVDOFhkZm1uWDQyOHpncEpMZWIrZFJlU1k1QjFuVXViR2pmWGd5dXhJNW9U?=
 =?utf-8?B?NEhFS3JaTituNWdOTHpLRlR3bkNVVElNelZZcmNGaUZzNG93b3ZrNm1WVVlK?=
 =?utf-8?B?OGNib2U5MkY4d1lDUVJGOWt3MWVjcjYveVd4VHRmMmxlQVYyMktWVk9xTTRS?=
 =?utf-8?B?MVNVVXhDSS8rYUtjcTJHUXhMMHU3b3NCcHRQWmI1TUNERVpubWU5MTVQV09x?=
 =?utf-8?B?QnN3MlFYYnpzNEt5eVQxYlhjMnpvSUI1MTNFUkJsL3liTlphMWxYQ3BQblBr?=
 =?utf-8?B?cGlENkdBN2J1L0lyWDYwZjRySUhXMmdIZTliR2h6aEVWcjYyMTB4RFJ4NXRD?=
 =?utf-8?B?bi9OLzFHRk81S2dPUk00Ryt5SCtsTmJvK3k0QmFwV2FNZG9xQnVWT0N6eE5B?=
 =?utf-8?B?REg2NENONDFPcFl5dW1XTWVxUTMxZTZXTHVBa0FyRXA4SGl4VldqMDduV2F5?=
 =?utf-8?B?YmxhUzJUWFZMVjBBL3BIRXNyeTh5NVhkWWlGMHFxNGp1Y1ZpMU9rODhhTy96?=
 =?utf-8?B?TUhoc0tmL2t1U29va3RhK1JpN0F0Qmg2MENScmhZcnJIclVETEFlTVdZbFBV?=
 =?utf-8?Q?Zoo8ZSFSQ1UO7sqMLU2vbaoRm+1iaFc4gm9L9yAKJm/eO/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c90037-ccc0-4708-1a1b-08dbcff001a5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:36:33.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCSP1n41hxTc8OaUKuXPz1GRDJSntOouIGBXyilL8y8Ck9jueoCTWK+Peh8uV87ny4dhNLDS8yyhRKxcHxK+FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_14,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180126
X-Proofpoint-ORIG-GUID: JmjlFgoX4GgM075qca3tVH_Y2lxGo21r
X-Proofpoint-GUID: JmjlFgoX4GgM075qca3tVH_Y2lxGo21r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 06:26:07PM +0300, Amir Goldstein wrote:
> On Wed, Oct 18, 2023 at 6:18 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Wed, Oct 18, 2023 at 12:59:58PM +0300, Amir Goldstein wrote:
> > > export_operations ->encode_fh() no longer has a default implementation to
> > > encode FILEID_INO32_GEN* file handles.
> > >
> > > Rename the default helper for encoding FILEID_INO32_GEN* file handles to
> > > generic_encode_ino32_fh() and convert the filesystems that used the
> > > default implementation to use the generic helper explicitly.
> > >
> > > This is a step towards allowing filesystems to encode non-decodeable file
> > > handles for fanotify without having to implement any export_operations.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> [...]
> 
> > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > index 5b3c9f30b422..6b6e01321405 100644
> > > --- a/include/linux/exportfs.h
> > > +++ b/include/linux/exportfs.h
> > > @@ -235,7 +235,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
> > >
> > >  static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
> > >  {
> > > -     return nop;
> > > +     return nop && nop->encode_fh;
> >
> > The ->encode_fh() method returns an integer type, not a boolean. It
> > would be more clear if this were written
> >
> >         return nop && (nop->encode_fh != FILEID_ROOT);
> >
> > (I'm just guessing at what you might have intended).
> >
> 
> You must be pre-coffee ;)

More like pre-lunch.


> This checks if the method exists, it doesn't invoke the method.

OK, I was confused because I thought you were filling in all the
spots where the method doesn't already exist. My brain lept to
the conclusion that this is therefore calling the method, but I
failed to notice there are no call arguments.

I might understand it now. :-)

Since you want this series to go through the vfs tree:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

