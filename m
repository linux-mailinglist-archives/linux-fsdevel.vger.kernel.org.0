Return-Path: <linux-fsdevel+bounces-2973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C891F7EE630
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 18:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1281F25284
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEE8111A5;
	Thu, 16 Nov 2023 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hj5cDkV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98882126;
	Thu, 16 Nov 2023 09:54:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0tgZ/7290IpR5Wo0jEctBCI0y/Bm7uzJMJ2/ojZ57v6yzzVgpXN2uCUrwA7s/rj7O1n1UwyW55e3ADBreO/NXAoQsi/nmoAx+KzgcD5IsKh9nQ/qcxrrAPpDb41+EnqsfEIiK1xCxWAnsl58vdGsfqsqST0rghNIMoVssB5a9lMBxSjlNpeilzlDVgaHNmHxHBjCo12R1Non6ZWYNi+Cv1QmRdonWaDJquuJPUQNBSsR8+xOjg+DuR1eKd7ySY0ZHIKdjRWdGtN4WPx/UPYlPbkdxltOKbZn8QKYLoh8i+ayv8L3NwcsqcHvGi0wtm7obeZrORYC5j4xZiEDnmf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dacs+K4w6UbxKhIT3YRdUcvFcVXvwh2mKm4JXJ3XUv4=;
 b=FVCF0BiZSPEEJOTrgzeZTN8+W2x/8lWEvzQiz+MZlH4WzQKKvRSWxFNcmbVFmNt6i80nppgzA+LU3NqiFDmM6+cLS8swQKZKN+9PvZsCVob0vMw2GjG0dlSmkDtzX5wIgHodj1nsTEA/L4uWD4sUPUFMePfa/vbE7NtozBzqdNK8DUlSWn0G9MVRB2c+ThDqGi8xFnxlgJfL3yTgzwFBfB4TYVfcEQh4cGCwTVvNf4/miEA5H6bSe176NZJu8vo/xPQE3VcTlEynVoBGod6Z+J5y2v5n3sQqPTZt7KIQKChKWAIPqIk61W81owGe4sI1kjS17w7J9qi22VnsZ7nBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dacs+K4w6UbxKhIT3YRdUcvFcVXvwh2mKm4JXJ3XUv4=;
 b=hj5cDkV5ZecCNq6BRoauStQv3kZK3mvp3zNP9jEtBhfxKuqGUsKbV0tJXFehX8Fq1ht19G1XmFcQFVz+lwjLu6m1X3tmfpimGDZVD6W2FzwnRt96EQzBB4wDs4vP7JKuWGJjfhNVj2Cmw0gSat/f6Mt2cqw0D5Dj/nhdIsGYyI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CH0PR12MB5202.namprd12.prod.outlook.com (2603:10b6:610:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 17:54:20 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 17:54:20 +0000
Message-ID: <71ad8b0e-984b-4739-a940-82c5a1456f50@amd.com>
Date: Thu, 16 Nov 2023 11:54:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v5 2/4] fs: debugfs: Add write functionality to debugfs
 blobs
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alexey.kardashevskiy@amd.com" <alexey.kardashevskiy@amd.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-3-avadhut.naik@amd.com>
 <SJ1PR11MB608345F0C62627E7A0520449FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB608345F0C62627E7A0520449FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::32) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CH0PR12MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 288eae05-37ff-4710-b8ec-08dbe6cd0f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lVXwTRyy8VovRxZLPPO+Qrj+mV3uVUwMd0W6MY2QP1/M+TEa4aXx/wvj/B1wD4RbET9Dot5d0L8Bweq0g7y6oyiN3lnzHOOrsG2ep535epsafkcJx+NvJ3uAtwLLJmll94DMGeSnK4BKfRn4jUQ1sFf+5UQqKNGxRqKUAMIOqESingTR8BCL4FPrm/cCxu+x9E45QC0vmClzkuV+yJ9Spdkico5ajYDMx+qyUoKCcQtl4nlPQooV6G3fumbN03BFfiEdqJI/jbl4LyMG9zhDI22b4z/BnAoWzUaCaAreFHanxYjZFvmDg2/3lJ9MpAD8ei5ZuAYtw7lvuAEmUgnq7pOrtO1BYy73gKpKS0ilydYkrZtRvuf4oFF5mys3qXZ126xfWdP7TjiREuRX0YaPmPqcWlIf+wVv0Thg82QVXWn8+5Cy/Xnoz8nG8Sq8BhsDgJSDBQk/IqUTu9/WDpAxXDDOiks8P+3c16mTdPgMDAl2kbUaA/BBc0xNSWsKBxEvO4r5/Z1xCCFUZc4LwrTgTztwBggOfcNe+NJ5HkEt3vfN0UcEZqMdxXppL/8QuPEfo+93r1usNBQE+2ECL1MBsnSf13dr4uFJb3JQsgBD4agR9WapTsWneLqKIkDXlaRfilhwLtC20pNWpHRbbHugalz6ulnk4jV9vwh2D5jaVvxH1XK6rsRNqXENFUkR4P8D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(31686004)(38100700002)(31696002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(83380400001)(6512007)(316002)(6916009)(2616005)(66476007)(66556008)(66946007)(54906003)(26005)(36756003)(53546011)(6666004)(6486002)(6506007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajVGa3VNR290TkJ2Ry84bW5ablNYTEpwM2tJLzEvQk5hS2FZY3hzbFBiK2RC?=
 =?utf-8?B?U1NKTDRONHRyb3Z3WHprTmljRG9mL3RNZHRadnVHUVp3MVlNZ0FheHJJR0tl?=
 =?utf-8?B?cTZEWkdlL0xON3FTQTlMeTB2d04ybFBNNExhd21KK2RESXVEVlE4dlIwZFhH?=
 =?utf-8?B?MFhUNzdVelVVNE1PSzhHL0J1aFIzRUo2VlhsdGFMdGE0SmNvZXc0dDd6c0Vs?=
 =?utf-8?B?NkxrcHNaWHRsVjVVb0t3MEdNaTNkT3BUdEFZZW9KNXN3clpBNWU1dFlvSVFl?=
 =?utf-8?B?L0c0eDZVenFpZ1ZjaHZmOU4zbERQczJsRFVpQTB2NnE0UGNwd1BHcVpPMVhQ?=
 =?utf-8?B?cmhVK2hlZTB3Vm1aNXBNZG1hcmpEblhIUm1RWk1LUmE5RWMxTGExSjFzZ1Q2?=
 =?utf-8?B?aU1BMWRWeDdCNmJ2UkRiaG1yVDFTdVBsaW1oWWFFbjZqSmdveXZidEZyNEth?=
 =?utf-8?B?QkJpYWZXSUo0NDFZUTdiYWRoaC9xeDdhZlVpS0NsNUxWUXRCc1hSMVdiVlVP?=
 =?utf-8?B?RVE2NzJqSkZIWW1FNmx6K3ozb0tqK2hXRUpHb1N1S1RrcVNiS2pGUDE1WWNo?=
 =?utf-8?B?V2VCWDl4Mmh6VWVpNFd1WWc4L0F5WVpoODR3VGs4MXFEZHRLVWhZM0VQQnBk?=
 =?utf-8?B?UXZNSk5GWTc3bUZqK0VBZDhmTW1COVRyRzJIaUdFY3o0dERSRjZ3a1FuSlQ2?=
 =?utf-8?B?Vmxjb3VGczZVSHhnU0VsdGJRUGV0VWdpLy9XVDhvM1dDbU5Cc2dOK1lkN1B5?=
 =?utf-8?B?YkJvc0FCMmpaTC8remk4MDVIOU1VZlJaYzh3c1F3SGVxOExDSWJEU0piRGV6?=
 =?utf-8?B?NEJLRU1naFJVRWJpL3VUYkhZbUUwblppZmNZdFA4M2hWTnFZWmxmbXUwSDZH?=
 =?utf-8?B?TWNETmt2YlIvaWZJYk96TldWbWM2Wll5b2tqWDRCU1JCSHV3Y0R0VE9Bdm1T?=
 =?utf-8?B?UmNWbER3TXQ3RnBDSXY3STJEc2RJTUVQSy94NENRNnVpVHB3MTdidGRtUU5s?=
 =?utf-8?B?N3NPT3JvNFhMLy9XclM4eWYxM0RycXBhcUtkT3NmYlJHc2ZWTWR1M2ZianBO?=
 =?utf-8?B?VFpEZ0dqeGhJRUQ5N0d6N3lxQmR6VWJDcG5qa25IeTFuVFBlUTJtRXl1QUZj?=
 =?utf-8?B?MUxNbFNPOS9Kb2E0Ynh6TU01Qzc5eFJIU05OLzYwcWtVaTRMRyt6bmU4SE1k?=
 =?utf-8?B?R2x0K3dEanEwbHVjbXZHM0xkVTZEQVRjbGtYL2s2KzhTZFZMTDR2TGN6Qmwx?=
 =?utf-8?B?ejJTdUdqaDJ2T3Y4TDMwaGErblFFQTJ5MitaRU5ITDZSVWJCME03MEx3Q3BH?=
 =?utf-8?B?Z0VUK3NRaTZOUjhiRlpHdnpwTDhld0o5aXZJMXRPK1gwUXFGTXNpV2h5Q1o5?=
 =?utf-8?B?WTl0L0NaTnQzT0NlakNTYlg2cjBoVmRPWjlzcUdzemY5MDlvbTRQRFdReXNa?=
 =?utf-8?B?OCtWOGZiTVo0Y1VuRndabnZNVGJ5Z3NsdnQ3T042UWdEc1FkMmlkTndmRURL?=
 =?utf-8?B?T1NhdTdoR0VZMDdUUXBWYzN5MS94b0d6M2JhSkZBVkNhTUN1SWVFc2tjbVpD?=
 =?utf-8?B?TGp1S0JYWVhlKytKNWtSMmY2a0Z3dGxidHVWQlNqZDRmZTFRVlBUd2ZxejBo?=
 =?utf-8?B?T1U3NWF6T05iaXQ0bTFFaFVVMDZiSS90K2xlME5icVFlZ1FQRmU2eWZzNnVp?=
 =?utf-8?B?dXJ2b2hBbUc1M0JaRmJBL0VtQXdJSnl6UWVjeUpsdC9DVS9VeWVMZXU4RHdv?=
 =?utf-8?B?TVZVVHJmaG9mSFJHYzU3cVAwTDhDdlV4V0h2WlNDaUdLVjFvdm5CZDZtWVNK?=
 =?utf-8?B?OFFIdmhUV0ZyK3lKVkhCQjNaZTNnVnZiYkNOeUdBNmJLRWs3dzNyNW5Ea3pC?=
 =?utf-8?B?RTF0dUxYMmpKcHVBK0lKT0F2cG5DWG5OUS9DTU5oSklRc0ZNejNiRWE4S0g0?=
 =?utf-8?B?UDg3MnpuMVBsaXNuQlFXaGs2bnFUZ21sMk44UTZ2SVU3dWlTNEVpZEZFVjV2?=
 =?utf-8?B?NTY4R0RBVnBXeTdCMVR3czZHK2lmdnhONGkwSUtiUk53c1RxQ1NObkNzQ3lQ?=
 =?utf-8?B?SGovbEJSTnI4V1NEdnRGK2R2UGI2VDUxdzROSjByR0lwcCtMYS9UcHJIL1Rn?=
 =?utf-8?Q?jwzEnkaGP24Pn0mmvJuHih3s0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288eae05-37ff-4710-b8ec-08dbe6cd0f0e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:54:19.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+Y9WY38XAwxUl9GrWZzAcxtSNHVbcUy60XhPqkIm0WLhQ0ueD+MYUrF2ptOaBua7VEpgG4s9m9CxtjhhP7XVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5202

Hi Tony,

On 11/7/2023 16:28, Luck, Tony wrote:
>> @@ -1042,7 +1060,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>> 				   struct dentry *parent,
>> 				   struct debugfs_blob_wrapper *blob)
>> {
>> -	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
>> +	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
>> }
> 
> The minimalist change here would be to s/0444/0666/
> 
Just realized that s/0444/0644/ might be an even more minimalist change since you anyways,
I think, need to be root for error injection through einj. Does that sound good?

In any case, using 0666 will result in the below checkpatch warning:

[root avadnaik-linux]# ./scripts/checkpatch.pl --strict -g HEAD
WARNING: Exporting world writable files is usually an error. Consider more restrictive permissions.
#84: FILE: fs/debugfs/file.c:1063:
+       return debugfs_create_file_unsafe(name, mode & 0666, parent, blob, &fops_blob);

total: 0 errors, 1 warnings, 0 checks, 54 lines checked

Would you be okay with s/0444/0644/?

-       return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
+       return debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);

> That would just allow callers to ask for writeable files without letting them
> add execute permission, or exotic modes like setuid etc.
> 
> -Tony

-- 
Thanks,
Avadhut Naik

