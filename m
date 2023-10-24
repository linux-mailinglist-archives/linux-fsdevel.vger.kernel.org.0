Return-Path: <linux-fsdevel+bounces-1099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912E17D54CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B5E1C20CB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8592E659;
	Tue, 24 Oct 2023 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u0ZwOuiD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pjTbEv61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449C2B776
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:09:54 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440A10EB;
	Tue, 24 Oct 2023 08:09:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCJKaY017900;
	Tue, 24 Oct 2023 15:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HnVLeXbZguisT33N6vgHS/DVi8DHMXJqmXX1G7SDmmQ=;
 b=u0ZwOuiDMEmeEZgutdd1tHGpbjFXd0fIn9f15zXuDfo4ZOgmC5OHauy/DnVpQTTTsEpW
 C8grOt+BysLAsp64iaCf/8VfyyIIhMTbseU/lU7Eo4JGnpEOnf/36u/be/6zSqB5IKeW
 sT/me/CXJDZZwdZ8R2jKahAoVbSDXUnihpjJVgpgMX4cNIllfvItgcfKXsXSC9ISGbOk
 mZqTcnTYaKLKbH3vT0cF74roe8UUM3iGssSpJvKDd/d/tYwhfMge0s71PqgogLJkng2B
 CpXKxNUPKDkC0zambC/vXWNLQZodkNyVxXxSC1e+5OF6xoY0+Somb88G4z5lcAbZbCWx aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbdqqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Oct 2023 15:08:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ODpRZ1015474;
	Tue, 24 Oct 2023 15:08:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv535cjws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Oct 2023 15:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQAgxP3YkdwwzGYfybUrZgKOMTPjNF1wBTNPGuToz22cfqIdJ21o12OSrJqVVJ9O0KHv2dXDAX0IqWkWRj3ejwIqEtC0RK6bGNjr0+3H01nbIeZ9pI2uPJXu9sQz46iGAH9L9MmyTEt9/wstbYvVgjw8EkKCXCRk0nokODghJtag7CuFP4kYpyea2SNE9SUcCsf9qXo2Ft3bW6hcu48cAXms91LYlgOkstAkGScc/XxRUG+x8q5frQ2tECgvgtvVnYDT1JFlSYSGWWsgwLYkV172qhueIEIh3B2X3h5vPv2SE6Wi3aGD1e/jARmkzNfgczj36uDhnUAS1rb03EAxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnVLeXbZguisT33N6vgHS/DVi8DHMXJqmXX1G7SDmmQ=;
 b=HK4tmYP7MyjNDzlRx50yrU4rvUeo79JDAcz91pYE+MMbIsDeiMUEN+Qq59QDGGoMRps8QupTP766aSgSVk8RA6o8Q7n7unmu5NydArHvRvn5oh3UB4jpvqOKEqU8gxiCCkyVfZSHkPa1idAfmpE5jTHfMSMkN2IVlWbkKwPSTYpVLLhz5/XPUAjBMHRc9//NvEwt9ZrlfmYvm7oXJMQUgjM34cadBlEOWv7exADGMM0iiz21NcBarm4em4k9/hHywyeTZ43u3LfFDvKIshfN9+P0Ccsne/CUf1EYqVjWrjCVVdOzootpuUPfybfjHf/FvyiCPpcBm1r74zMdA0w6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnVLeXbZguisT33N6vgHS/DVi8DHMXJqmXX1G7SDmmQ=;
 b=pjTbEv61oR3xqc+cRl6yznJoHdTPQKTCoQYOtKFKbH61+GbCLyeOvHI6+PivlOWj/B/1lji1rj8LsXBxvcqKBCie/3khXYkFPaZnsfu+N2txKpUCJQo0gaF/H/2TQeUwjsCw8xoQk5B99wobVNDeOVZ5X92jujhH3mztHRIxzQU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 15:08:35 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6863.043; Tue, 24 Oct 2023
 15:08:35 +0000
Message-ID: <4f45046b-5bd1-4f14-a34f-9628ee801531@oracle.com>
Date: Tue, 24 Oct 2023 10:08:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] exportfs: make ->encode_fh() a mandatory method
 for NFS export
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Steve French <sfrench@samba.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Evgeniy Dushistov <dushistov@mail.ru>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-3-amir73il@gmail.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20231023180801.2953446-3-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:610:38::14) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ddf768-756c-4f2c-5b63-08dbd4a31812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e666EL1ueFRVIsrVI6mzEDo346Bv3CVPfx63/pGi8W4cnz0kKfaeRIQljulz6ovU7ms6BJoPzX7f+pQ6uqESNfBp18ATxKcRnUBjYmL0S9gonyfjqiiBBlekqdZIs4RuJ8HXFH9YNzcc/nxlC9taHSIvdHUS9fUpubJJiv1J7S0Y0UlSzSuqU1hl34JiiAvU1p8qka5vs89SF3g0lJfNLmLuIgTWRFnoXvuOefm7d2o+bvC9W4AQM7wweDipmtb3lMOMqSXK3VdWgLSK9Ajeq8qnArtcfr/5kd4ltzRBE+CRVuEuZK09RAC/K1vIYAzoUigny7Q25gIG0OmRq5BYqireB4nnz2rUeLCln/Q7i0QLUz94hfqnlprMCcgIx21+CGQIPJXTa53l0rgg7X3bp+MWt+Ftqg9fQ6vot+ftrMKpZuYp9FWbIMEpHlBukSRtM81iWIur4CDKCoHki3HF5bhXROudLk7JTHg0OCgqn5oAsHe6lEDRFcaJ+6MQGoSNoz0e4v+HgxAc2kUQS8EEgMnlfMsjlT0buGB8OA+H8w3h9SEIOHuJchYythoEerdLvrG984hhtGTVi23KeQzKPC/KVu2ChEqW5mjGU07PLJVIHjWC3FVytdyB17z7vQL6Tm0W8tIuNaV2i4htpbwOnw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(36756003)(2616005)(26005)(6512007)(6506007)(38100700002)(6666004)(31696002)(110136005)(316002)(66556008)(86362001)(66946007)(54906003)(66476007)(6486002)(478600001)(83380400001)(31686004)(41300700001)(4326008)(44832011)(8936002)(8676002)(30864003)(7416002)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N3VyWkc4RENXYXZ6b0dldVBpZmppc1kyUUJGYmZNNVp5aVg3elJPT25aUThX?=
 =?utf-8?B?dzB5MkJNNGZyMHFMd3RCK1U2TlNyWm9xdlppcGs5RXcra2tWUDc3VlpaK0FK?=
 =?utf-8?B?RmxPdkw0dENvdkV3T2tUL0RUOGZOU1g1OEVpN2xWeUlyU2F1bnY1VG4vVFkw?=
 =?utf-8?B?TmV1Q0FkWlJMTWdTUWFidjJGSW5vM2tNTW9yemlBYWhvYko5NTJaTklUMFA0?=
 =?utf-8?B?dUw0UHF3aS8rczVkUmNJVERubmgyRWhyM1J1UE8zNk5LcmZ1MExHb1MwTXpy?=
 =?utf-8?B?YXpGQ2o1WmZKOWJUYjBMTEhHOTh1ZDZueXdXSnU3VzhoM2FndFh5WHlrVzlv?=
 =?utf-8?B?QmMrSUVFODY1VEw5SjZkaU1TUTY4aFFpMlJPSlRSRVloT0FXMHpacEJmblRZ?=
 =?utf-8?B?RktuQ1hIY3RKbjhBMkQwZXl4YXVwQ0x3NTdSaGo0alVxWUpIdjRGZkp2cmdO?=
 =?utf-8?B?YVRNMm5tNThUSTZlMk0wK0xOa2FMaDNsbWJ5SHl0ci9iQUcydkk4UWoyOTN6?=
 =?utf-8?B?c3BtUWhhUVV0YnFma3ptQkVrRFRnVzBZZHVETFhscm0vZ2l6WTVHNGVWNUNi?=
 =?utf-8?B?RFcrc0Rtc1VHT3FoMERFN1JNdVhwWENRWGtFM3RQWFZ0dE5pSWVWMGVqeUJK?=
 =?utf-8?B?bkMzVVNGZ3BpM0tpaEdwTTlYRlNYYzBMZVk5NEtlQ1RnNnEyVWlyZ3dBZHBk?=
 =?utf-8?B?djY1elpKam42Sk9pUlFFWXI3SjFTWEg3WUcyTXRUUXdhbnJWZHR5RVVRNnlH?=
 =?utf-8?B?bmNEM1U5SUp3YVQzMUlXdjRXVXRsYU1zcm5DZHVhVEllRWNKN2xSbmU0djlX?=
 =?utf-8?B?bGIyTHM1L2d6Z3dXSWQwM0llc2h0djFDZzdoMENWcHdTL2F0dUpxZ0g4RDlB?=
 =?utf-8?B?Q2VZczYrT2RBaWJ6OGQvcFppNHdHU1BPYk9vcTQzcVVicHpaNFk4QWxqdnJn?=
 =?utf-8?B?NmQ0UXJTQWkvSmxPSVdwNzVXdGptV1RQSmRKeW1SaWpVSThTbTI4c3lkUDJq?=
 =?utf-8?B?U1BiVUQ1a29IU0VBTDJ1cXNrd1JPc0UwRS9mSEpXUWhBL3B2OVhwTmtiajZJ?=
 =?utf-8?B?T01XUTQ0V3RpY1J4QXBQeCtIRGFuMjZ5L3o4OTRQdnllMGV0NXc2MXRGRWpz?=
 =?utf-8?B?UEU5eVJOL090MjdrTGdWWmgvUlJ0a2VmV1pQZkhNcGlNZmJHdS8yMkYzY0NU?=
 =?utf-8?B?VHd5SXI4ZWovVW1ZUFZsRGFVVU43WUgveWJuUnBtaGpENHh5TnVWWUZCUUY3?=
 =?utf-8?B?dEpwbzRNcWIxNlZwbFQrRVRmVVJFS1kybFo3MEQwRE1CUllyWjVsbWhhK3JG?=
 =?utf-8?B?VnNmZUFzYit6VzhOUktDN2g5RENNVXZ6alZWWk5mYTBBcnkxeVpJajcxMmxD?=
 =?utf-8?B?dzZCL3NWOXRHNWhFdjRKTjhQRTI1S1kzMDAyQ0tkYzB6L2lSK0V4VmFCWGRF?=
 =?utf-8?B?M3ExUWRzOURZU1lRL0xqYnNyR1NDZWpCMDE5Um84ckxwSjYvWXRseThTS1Zi?=
 =?utf-8?B?OElwSmpkMDZ1aEd5T0RrWkN3RWJFY2I1dnJzRTl1N25mU3JJQ2ZlVEovTVIv?=
 =?utf-8?B?V0hSYlRaVU5ib200Q01XMlB3VWo1QjlPdWhPTGRURWFWM2xCMnRpeU1HZXpl?=
 =?utf-8?B?MS9FdHlUSGphOHArQnpQU002Q3VsaXFoTmRMZlNMUU9kbWhZcUtrWWdWSDhF?=
 =?utf-8?B?Sm1tVnhRdlBkSUZXZTNodzFHTExCazhjNHZKdU1TS0hrQVNRVGI2M3BIbEp0?=
 =?utf-8?B?ME5LRmZWVVhqeHhhS3BpOVRIRDhTSW9EUWxCMjhVNEgwdDBITndaQXpXVWNG?=
 =?utf-8?B?UWcwZTJyVXBqb1VaWHUxU0R3eGV6RDF0a2g0YnFkVCsrNk1EenNXL3RhcUFI?=
 =?utf-8?B?SzEvV1M2MlgzTDh2RDJ6RHhlajlmOG1WcXhzWElZTFNQMHAzcmJuaE9rb0Ft?=
 =?utf-8?B?eVVsTlA2UDI2RyswSTVsaDZ1QlV1bVE0QjVQajk1NEoxRzkzNVlNWUExK1Ir?=
 =?utf-8?B?bWY1a25zYnNGd2owQkxHU2VsMmNIRWltQkNFUUFtTzhCdWtYeEpiSzhWSEVN?=
 =?utf-8?B?K1VFZ2pqWU1oNnRkMmYzQmlBUCt1c0lVdi8xUjd1bC9UOGNqVW04UUpnV1ZO?=
 =?utf-8?B?MUM2SlhkalU2VmtTUXJVbmxiZWZraFpQMmpFTGFPY0dYTDBXU0RHQkNQNmgw?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?dGRqLzJTQ083cmxOdlNzeGJSRS9ZcnR5akx6c29UNUd3NGNMSnNaYVNOKzZy?=
 =?utf-8?B?ZERRUnVpQlA1UU0zTmtyb0lLSXl6TDFTUmtzb05raTBRazlXZWQ5bW1zL1FF?=
 =?utf-8?B?TXdSSHhheXFVbTZJWDd4L01kUUMrcndEYkhzeUo1NVR4OW5pbE9rMElQZ29h?=
 =?utf-8?B?ZmUzOGdhS3lJL1RKaW1uUUFVN3JDVklzMTdodkdpSTVwUHlBSFFaeTVJd0hW?=
 =?utf-8?B?RUhWeXRuYy84eGU5WG4zek81U1JtTHBRNzZqbVBWeFp6RjBnY1VxTlIzc3NY?=
 =?utf-8?B?eFFOcmhFVXdtb3lQeFhtOEpZRFhqRXV0TzhUOEMyR3JiaGpyUkowV25RSTl5?=
 =?utf-8?B?S1o2NzFtT09HVU9QZXRPMWwzZWoxeGNmOTJKdzBtQ3JuTVBrVWMzN0xCRjc5?=
 =?utf-8?B?cWprTXdOa01BYmRKdzA1ajJQcm9ic2t6ZkZZeXM0L1BXQ3JqeDRZbXdIQUlJ?=
 =?utf-8?B?bkpzT0pNTytrL2RqalgyeFdoaW15bU95T1lBQVhFcWtqVnpyb2lMdXNIQzNx?=
 =?utf-8?B?bHo1Zk1Tc1JhNmNtdHZ5RW5TQ1R6VGFpN3RoWkttQ05jdGZObXNIRU8zM3h2?=
 =?utf-8?B?U3ViSVpCRWpZRFdVN0VVZllCdGl6ZVV0MGxPTnU3K0hFdXlLSzRWc0RHMG9W?=
 =?utf-8?B?YUQxWmIwSEQvOXNoVkVmcERSL05CUFh2ejBxTDd0UDZMTERYSVQ3dm9FbU85?=
 =?utf-8?B?bUdlbjBDOENGQ1BCRGVWM0RRTHBLR1I3MlpjdjVqWkhZTmRybHFGZjFJVHR5?=
 =?utf-8?B?Y2ZOdzlvcEVTUlpxTlcvekJJRnJqa04rK20vT09GL0o3QzJnak5MMWFtVXUv?=
 =?utf-8?B?dnY1Qnd6SGNsRFFKTXd4Z1BqM0gwY2hZZGlDdXdwaGlaRHZUeFBaOFhFMG5i?=
 =?utf-8?B?SlFZZTJNN0duaElWMWoyamZ4UWRjZ2NGYzRTSm1STXpCVW1NNUJUNW5pVGJW?=
 =?utf-8?B?d1M2U2YvUEg5Ri8rMkhBdmVTbWladkxYbUhGVzgyR2JvU2lSQTh1VHBUcjFN?=
 =?utf-8?B?Q2cySUd2bGdzZmQ1bEZZUHJGNFhhbVBmUURma0ZQQ0FkbGRxK3orSDJZRUJK?=
 =?utf-8?B?OHAvYnNTbHpEcXUxeVg2SldRSk5OMVVOeVJRWDJ3aDAvUFhJQTRqMEF5ZFYv?=
 =?utf-8?B?Zkl6bjNEVitUdDRMOW8rY28vNS9qblIxekhDKzNTSVFLb0RLTERtLzVYYVhm?=
 =?utf-8?B?T1NiVUtUa3BZSlZESVpIU1RNbFJReUxqSXhxTFFaYkRQaUV3U1dNaGtWZEov?=
 =?utf-8?B?N3ZoY0RNeko2a2UzOTI4TGovSi8rd1o3RUEzb1JJVHBva1lkMVpCOTJyT3Q3?=
 =?utf-8?B?UXdSbEF5dUg4d3RWa04ydmI3dml3UU5yWktLeWZsaGVZMks4RXIvQUtFMmZ6?=
 =?utf-8?B?Q1l2Unh2N3JOdXdLMjBlYlY1Yis3TDVtT0hZQ2dpbWUrSGd4a2NHc29aZG9T?=
 =?utf-8?B?MkhRMytRRzR5L0orazhlb1Zkc1lYdGVuZ1VKL1E1ejhuQjMzMURwRkZQSlZr?=
 =?utf-8?B?eS9zMEJuVGIySHlhV2pnRytxQk50SEc5SW1CZ1Z0cnRuN01IUzdTcmIzemVX?=
 =?utf-8?B?N0s1RHdUbzdMYXVHSmR0dnBaNEZKRHJVclZyU0VuUEY1WDBCa0VNU0NPQXJS?=
 =?utf-8?Q?zkSkgaq7Gcq+T8iidkuQnh4Em3baK7M3Ut/82k2EdLxw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ddf768-756c-4f2c-5b63-08dbd4a31812
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:08:35.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7AcmEShXKTfxa6iXlCGcMcq9mZzf9sAgXl+26dexkaKZNbifEvHkFHNHPshENt0WeDDS2wZJmPtSGOsQxDgi8dIhZsxW5fPgRs+wu6P4xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_15,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240130
X-Proofpoint-GUID: nVkEorAjp82n4at6cckYuuv8mvWT0ZnA
X-Proofpoint-ORIG-GUID: nVkEorAjp82n4at6cckYuuv8mvWT0ZnA



On 10/23/23 1:07PM, Amir Goldstein wrote:
> export_operations ->encode_fh() no longer has a default implementation to
> encode FILEID_INO32_GEN* file handles.
> 
> Rename the default helper for encoding FILEID_INO32_GEN* file handles to
> generic_encode_ino32_fh() and convert the filesystems that used the
> default implementation to use the generic helper explicitly.
> 
> This is a step towards allowing filesystems to encode non-decodeable file
> handles for fanotify without having to implement any export_operations.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>   Documentation/filesystems/nfs/exporting.rst |  7 ++-----
>   Documentation/filesystems/porting.rst       |  9 +++++++++
>   fs/affs/namei.c                             |  1 +
>   fs/befs/linuxvfs.c                          |  1 +
>   fs/efs/super.c                              |  1 +
>   fs/erofs/super.c                            |  1 +
>   fs/exportfs/expfs.c                         | 16 +++++++++-------
>   fs/ext2/super.c                             |  1 +
>   fs/ext4/super.c                             |  1 +
>   fs/f2fs/super.c                             |  1 +
>   fs/fat/nfs.c                                |  1 +
>   fs/jffs2/super.c                            |  1 +
>   fs/jfs/super.c                              |  1 +
>   fs/ntfs/namei.c                             |  1 +
>   fs/ntfs3/super.c                            |  1 +
>   fs/smb/client/export.c                      | 11 +++++------
>   fs/squashfs/export.c                        |  1 +
>   fs/ufs/super.c                              |  1 +
>   include/linux/exportfs.h                    |  9 ++++++++-
>   19 files changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
> index 4b30daee399a..de64d2d002a2 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -122,12 +122,9 @@ are exportable by setting the s_export_op field in the struct
>   super_block.  This field must point to a "struct export_operations"
>   struct which has the following members:
>   
> -  encode_fh (optional)
> +  encode_fh (mandatory)
>       Takes a dentry and creates a filehandle fragment which may later be used
> -    to find or create a dentry for the same object.  The default
> -    implementation creates a filehandle fragment that encodes a 32bit inode
> -    and generation number for the inode encoded, and if necessary the
> -    same information for the parent.
> +    to find or create a dentry for the same object.
>   
>     fh_to_dentry (mandatory)
>       Given a filehandle fragment, this should find the implied object and
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 4d05b9862451..9cc6cb27c4d5 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1045,3 +1045,12 @@ filesystem type is now moved to a later point when the devices are closed:
>   As this is a VFS level change it has no practical consequences for filesystems
>   other than that all of them must use one of the provided kill_litter_super(),
>   kill_anon_super(), or kill_block_super() helpers.
> +
> +---
> +
> +**mandatory**
> +
> +export_operations ->encode_fh() no longer has a default implementation to
> +encode FILEID_INO32_GEN* file handles.
> +Filesystems that used the default implementation may use the generic helper
> +generic_encode_ino32_fh() explicitly.
> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> index 2fe4a5832fcf..d6b9758ee23d 100644
> --- a/fs/affs/namei.c
> +++ b/fs/affs/namei.c
> @@ -568,6 +568,7 @@ static struct dentry *affs_fh_to_parent(struct super_block *sb, struct fid *fid,
>   }
>   
>   const struct export_operations affs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.fh_to_dentry = affs_fh_to_dentry,
>   	.fh_to_parent = affs_fh_to_parent,
>   	.get_parent = affs_get_parent,
> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
> index 9a16a51fbb88..410dcaffd5ab 100644
> --- a/fs/befs/linuxvfs.c
> +++ b/fs/befs/linuxvfs.c
> @@ -96,6 +96,7 @@ static const struct address_space_operations befs_symlink_aops = {
>   };
>   
>   static const struct export_operations befs_export_operations = {
> +	.encode_fh	= generic_encode_ino32_fh,
>   	.fh_to_dentry	= befs_fh_to_dentry,
>   	.fh_to_parent	= befs_fh_to_parent,
>   	.get_parent	= befs_get_parent,
> diff --git a/fs/efs/super.c b/fs/efs/super.c
> index b287f47c165b..f17fdac76b2e 100644
> --- a/fs/efs/super.c
> +++ b/fs/efs/super.c
> @@ -123,6 +123,7 @@ static const struct super_operations efs_superblock_operations = {
>   };
>   
>   static const struct export_operations efs_export_ops = {
> +	.encode_fh	= generic_encode_ino32_fh,
>   	.fh_to_dentry	= efs_fh_to_dentry,
>   	.fh_to_parent	= efs_fh_to_parent,
>   	.get_parent	= efs_get_parent,
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3700af9ee173..edbe07a24156 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -626,6 +626,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
>   }
>   
>   static const struct export_operations erofs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.fh_to_dentry = erofs_fh_to_dentry,
>   	.fh_to_parent = erofs_fh_to_parent,
>   	.get_parent = erofs_get_parent,
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 9ee205df8fa7..8f883c4758f5 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -343,20 +343,21 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
>   }
>   
>   /**
> - * export_encode_fh - default export_operations->encode_fh function
> + * generic_encode_ino32_fh - generic export_operations->encode_fh function
>    * @inode:   the object to encode
> - * @fid:     where to store the file handle fragment
> - * @max_len: maximum length to store there
> + * @fh:      where to store the file handle fragment
> + * @max_len: maximum length to store there (in 4 byte units)
>    * @parent:  parent directory inode, if wanted
>    *
> - * This default encode_fh function assumes that the 32 inode number
> + * This generic encode_fh function assumes that the 32 inode number
>    * is suitable for locating an inode, and that the generation number
>    * can be used to check that it is still valid.  It places them in the
>    * filehandle fragment where export_decode_fh expects to find them.
>    */
> -static int export_encode_fh(struct inode *inode, struct fid *fid,
> -		int *max_len, struct inode *parent)
> +int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
> +			    struct inode *parent)
>   {
> +	struct fid *fid = (void *)fh;
>   	int len = *max_len;
>   	int type = FILEID_INO32_GEN;
>   
> @@ -380,6 +381,7 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
>   	*max_len = len;
>   	return type;
>   }
> +EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
>   
>   /**
>    * exportfs_encode_inode_fh - encode a file handle from inode
> @@ -402,7 +404,7 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>   	if (nop && nop->encode_fh)
>   		return nop->encode_fh(inode, fid->raw, max_len, parent);
>   
> -	return export_encode_fh(inode, fid, max_len, parent);
> +	return -EOPNOTSUPP;
>   }
>   EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
>   
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index aaf3e3e88cb2..b9f158a34997 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -397,6 +397,7 @@ static struct dentry *ext2_fh_to_parent(struct super_block *sb, struct fid *fid,
>   }
>   
>   static const struct export_operations ext2_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.fh_to_dentry = ext2_fh_to_dentry,
>   	.fh_to_parent = ext2_fh_to_parent,
>   	.get_parent = ext2_get_parent,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dbebd8b3127e..c44db1915437 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1646,6 +1646,7 @@ static const struct super_operations ext4_sops = {
>   };
>   
>   static const struct export_operations ext4_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.fh_to_dentry = ext4_fh_to_dentry,
>   	.fh_to_parent = ext4_fh_to_parent,
>   	.get_parent = ext4_get_parent,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a8c8232852bb..60cfa11f65bf 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3282,6 +3282,7 @@ static struct dentry *f2fs_fh_to_parent(struct super_block *sb, struct fid *fid,
>   }
>   
>   static const struct export_operations f2fs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.fh_to_dentry = f2fs_fh_to_dentry,
>   	.fh_to_parent = f2fs_fh_to_parent,
>   	.get_parent = f2fs_get_parent,
> diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
> index 3626eb585a98..c52e63e10d35 100644
> --- a/fs/fat/nfs.c
> +++ b/fs/fat/nfs.c
> @@ -279,6 +279,7 @@ static struct dentry *fat_get_parent(struct dentry *child_dir)
>   }
>   
>   const struct export_operations fat_export_ops = {
> +	.encode_fh	= generic_encode_ino32_fh,
>   	.fh_to_dentry   = fat_fh_to_dentry,
>   	.fh_to_parent   = fat_fh_to_parent,
>   	.get_parent     = fat_get_parent,
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index 7ea37f49f1e1..f99591a634b4 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -150,6 +150,7 @@ static struct dentry *jffs2_get_parent(struct dentry *child)
>   }
>   
>   static const struct export_operations jffs2_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.get_parent = jffs2_get_parent,
>   	.fh_to_dentry = jffs2_fh_to_dentry,
>   	.fh_to_parent = jffs2_fh_to_parent,
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 2e2f7f6d36a0..2cc2632f3c47 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -896,6 +896,7 @@ static const struct super_operations jfs_super_operations = {
>   };
>   
>   static const struct export_operations jfs_export_operations = {
> +	.encode_fh	= generic_encode_ino32_fh,
>   	.fh_to_dentry	= jfs_fh_to_dentry,
>   	.fh_to_parent	= jfs_fh_to_parent,
>   	.get_parent	= jfs_get_parent,
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index ab44f2db533b..d7498ddc4a72 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -384,6 +384,7 @@ static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid *fid,
>    * and due to using iget() whereas NTFS needs ntfs_iget().
>    */
>   const struct export_operations ntfs_export_ops = {
> +	.encode_fh	= generic_encode_ino32_fh,
>   	.get_parent	= ntfs_get_parent,	/* Find the parent of a given
>   						   directory. */
>   	.fh_to_dentry	= ntfs_fh_to_dentry,
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 5661a363005e..661ffb5aa1e0 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -789,6 +789,7 @@ static int ntfs_nfs_commit_metadata(struct inode *inode)
>   }
>   
>   static const struct export_operations ntfs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.fh_to_dentry = ntfs_fh_to_dentry,
>   	.fh_to_parent = ntfs_fh_to_parent,
>   	.get_parent = ntfs3_get_parent,
> diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
> index 37c28415df1e..d606e8cbcb7d 100644
> --- a/fs/smb/client/export.c
> +++ b/fs/smb/client/export.c
> @@ -41,13 +41,12 @@ static struct dentry *cifs_get_parent(struct dentry *dentry)
>   }
>   
>   const struct export_operations cifs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.get_parent = cifs_get_parent,
> -/*	Following five export operations are unneeded so far and can default:
> -	.get_dentry =
> -	.get_name =
> -	.find_exported_dentry =
> -	.decode_fh =
> -	.encode_fs =  */
> +/*
> + * Following export operations are mandatory for NFS export support:
> + *	.fh_to_dentry =
> + */
>   };
>   
>   #endif /* CONFIG_CIFS_NFSD_EXPORT */
> diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
> index 723763746238..62972f0ff868 100644
> --- a/fs/squashfs/export.c
> +++ b/fs/squashfs/export.c
> @@ -173,6 +173,7 @@ __le64 *squashfs_read_inode_lookup_table(struct super_block *sb,
>   
>   
>   const struct export_operations squashfs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.fh_to_dentry = squashfs_fh_to_dentry,
>   	.fh_to_parent = squashfs_fh_to_parent,
>   	.get_parent = squashfs_get_parent
> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
> index 23377c1baed9..a480810cd4e3 100644
> --- a/fs/ufs/super.c
> +++ b/fs/ufs/super.c
> @@ -137,6 +137,7 @@ static struct dentry *ufs_get_parent(struct dentry *child)
>   }
>   
>   static const struct export_operations ufs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>   	.fh_to_dentry	= ufs_fh_to_dentry,
>   	.fh_to_parent	= ufs_fh_to_parent,
>   	.get_parent	= ufs_get_parent,
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 5b3c9f30b422..85bd027494e5 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -235,7 +235,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>   
>   static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
>   {
> -	return nop;
> +	return nop && nop->encode_fh;
>   }
>   
>   static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
> @@ -279,6 +279,13 @@ extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
>   /*
>    * Generic helpers for filesystems.
>    */
> +#ifdef CONFIG_EXPORTFS
> +int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
> +			    struct inode *parent);
> +#else
> +#define generic_encode_ino32_fh NULL
> +#endif
> +
>   extern struct dentry *generic_fh_to_dentry(struct super_block *sb,
>   	struct fid *fid, int fh_len, int fh_type,
>   	struct inode *(*get_inode) (struct super_block *sb, u64 ino, u32 gen));

