Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25C2774681
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjHHS5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjHHS5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:57:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BF51D3FF;
        Tue,  8 Aug 2023 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691515026; x=1723051026;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+G053CkV/ayGYV3wiup57TaqMVaqR0ZQmz+4nR4dIgY=;
  b=mZNY1T8CkHcmw7gbXCHH+gHCThTWhYN7P6JJZ1ahICHHqlOcX7RPM3PJ
   4KWiSqQTVtKZfNsY9KONAQpn8AfO71MqB/rzG2KkNSRbar/NL7VXvVAjr
   W07r3Thrw5v8yLEsTnS7v0JTqIU9j9ladoVAkQQ4lHZQ84E78ItFiFXWK
   bnk7Rz9XCQnqLWIO7aBAHgKaLDZTiZji8cB/CMeuA0zq2zKwpedW3hQ5p
   LwmDTIckiLspPX9iLvxKa2GxSSwlPhGt/ksE18hcTG4Q0rPMy31sSQP1O
   Qxd+kqPDi0qtshRifzZ5m4vHiVgVgVDahTrPIM+y6V/D5+mqEmlTDimEN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360887306"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="360887306"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 04:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845437879"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="845437879"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 04:21:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 04:21:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 04:21:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 04:21:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 04:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grQP9TuCUAWgevZS8dt8XW6OxRS2igdfXOshMHM3U1LSAsZ5Z393im1q3SfIYx8Z1d3EGZzXUc94q/Tzw2jGUjqf0NeVzs2LrGuJR/ceEj8nXlPfN8vOwb6aAQpCMW9IExpyxY0tH3LS57ZSgAU2nnaJsnPxwz7blwGkq6NJKlPfyxrPF0+WtHZDo4WR64qqA3GnhkNlqcm6Lfi0R4U1eIvurpqhRa9yjMEM8YPOxo7suERtyIXZZ2LBkfidjUQj01S1dwSqTnHzK4nAwNoO6w3RG9M43wTFfXBN1WOeVkOmZTe3uisywqw1Qrkv/mdiVHUzaufylRJnWE0ItiXFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8qxKyBUjeEZFV+IT2VEkAGRU6QZmLOaGMBYFriN2ns=;
 b=oHMgzIESt3wZ839PAjo8pNMBLudGi5K1di9x5+CMyoXc1XqnaK4J6wainZISXJPYpawp4DaoYdBM6BKWjUqyVrKLpgWzfGL0ZmdGTI57VraH37jDSpx/BZHiv5YAA83GJne4YzYdWtyqeTuZcs7NgJxkK0xUaNQQmIRMylRQIlnoC7uuE7oasaqLm0soiVB0P8KMtYJ6bTPSX7RgBGC/519s4aD9EDsCON+2wvJZjNM1lX6/SH3qG6etf8aTsR7/F8+c/cNmU76kPNK4Tkb/kCoLAAzXLtlqCiweedZZ/wqP6S2MPhU4gCRR4pwWsOSTd7HgbWX18/P4fOWuseP4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3674.namprd11.prod.outlook.com (2603:10b6:5:13d::11)
 by DS0PR11MB8761.namprd11.prod.outlook.com (2603:10b6:8:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 11:20:59 +0000
Received: from DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::7f4:c05b:358b:79c4]) by DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::7f4:c05b:358b:79c4%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 11:20:59 +0000
Message-ID: <22e0e672-f9f6-6afe-6ce6-63de264e7b6d@intel.com>
Date:   Tue, 8 Aug 2023 13:20:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 11/14] networking: Update to register_net_sysctl_sz
Content-Language: en-US
To:     Joel Granados <joel.granados@gmail.com>, <mcgrof@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Kees Cook <keescook@chromium.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>, <mptcp@lists.linux.dev>,
        Jakub Kicinski <kuba@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, <coreteam@netfilter.org>,
        Jan Karcher <jaka@linux.ibm.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        <bridge@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
        David Ahern <dsahern@kernel.org>,
        <netfilter-devel@vger.kernel.org>,
        Wen Gu <guwen@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        <linux-wpan@vger.kernel.org>, <lvs-devel@vger.kernel.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-sctp@vger.kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Florian Westphal <fw@strlen.de>, <willy@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-rdma@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Simon Horman" <horms@verge.net.au>,
        Mat Martineau <martineau@kernel.org>, <josh@joshtriplett.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Dumazet <edumazet@google.com>,
        <linux-hams@vger.kernel.org>,
        "Wenjia Zhang" <wenjia@linux.ibm.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        "Nikolay Aleksandrov" <razor@blackwall.org>,
        <netdev@vger.kernel.org>, <rds-devel@oss.oracle.com>,
        Joel Granados <j.granados@samsung.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <20230731071728.3493794-12-j.granados@samsung.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230731071728.3493794-12-j.granados@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To DM6PR11MB3674.namprd11.prod.outlook.com
 (2603:10b6:5:13d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3674:EE_|DS0PR11MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf6b4ad-3764-4cb8-03b5-08db98018a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lV+FAHkgfA/bdqyhwtYLZNIWCD6wzb8SfXdTO6JX6KYUY8GYW7k6nedGPdd2dxr27qPd1YvNR/tJ2tvZAfsn38XFAuYQdCAg+GlpHFT0TAsyzETenc0K0tH5x4adwPHBAytD5VCv4eKh1r4OseMhpHOf97+5/gEG70R+wT27BTr5aWNmwuB/WcfpOqgSn4Wy5Mgg+4Rbuxmuo5DISabl9E11/z6IpyyABI1YVnSgPzEB2v8Ojwkoi102EwLcHy4GTkVTRTXtyMyKMVsPh3UtuY9+b5KSLcRCQBirlcrwlVi2zH72bCc3L/VjTQhG1ne2m+QHCUv3SaBCmZgOz6HdlEw1kLUvhUetzuiJJ1JAF5vMTtRYfEqBs3o1auaCuo79fTbjJeBb49a0Zx43lmxpQLPn7WP3r81OeTci3VlLvYiiGCZsD8OYt+faciJ4HxsQuwJA2lBjRi6ri3mhMENQb8zElG9iQy1N67G4R90phwPZdMPWShAm9CieuB0WklwzHDHnikohXRZfvQTtk84C5zo2rIXRez5COK5L4kyI7CM29jSZvr3TkkjEIGd4krLRONRXcaa7oBCmRCmaq657OlKbvUFykmIn8S/PgzH8og5l5u55bP2wnd/X8IbqF2bBfJ4L+fk9hNcEqcDHvCSMTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(186006)(1800799003)(86362001)(31696002)(41300700001)(53546011)(7406005)(478600001)(6506007)(8936002)(7366002)(8676002)(26005)(7416002)(38100700002)(6486002)(6666004)(2616005)(5660300002)(36756003)(2906002)(30864003)(83380400001)(15650500001)(54906003)(31686004)(316002)(66556008)(66476007)(66946007)(82960400001)(4326008)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm0xQVRucHp0bXBBbTB5RzJ3R2QrQzBydDNoeWJzMFlXOCtwYWs2dW5lTjZ5?=
 =?utf-8?B?K3VDcVRlbDdkdFdFYlZKOXhpL3FWWnJSWUtYbFhTODNKRmRjN0JrSUVXVkRN?=
 =?utf-8?B?R3RqcVJmMDc3RXJ5ankwSjAwZ1E5bS9FNnhnRHJvYjBodWZzZTNMMHhHRktP?=
 =?utf-8?B?aW9PTFhQMGFPZC83MzNBNnpvYkJMZ1c3Rk4xanVUNnppWFBpbVgzejdZS0dy?=
 =?utf-8?B?UVNzQnU5UlJqL09ISzVGb0t5VHcwY0RiRDRuU09pTFR0S1UyZkt2Szh2YjBF?=
 =?utf-8?B?YXBXT0dnSzRYVkI5SWZsRWxYblVUbDFxZ21NNzh4SWVHaUJvcTVWM2tyb3Bk?=
 =?utf-8?B?WmNIUjM3T1NsL0tPQ24yeFc2eE5yQVVkbXo1bWtncUtEOVpKT05LMHE1WEV3?=
 =?utf-8?B?eU02eFhRMXV2aCtJRmU3c2J3TXdmMmtZcUR5SUorZWZuSXovNWFlUmFseGFj?=
 =?utf-8?B?dFQ2T1NkdWhYQkliYmlVbUoxSWZqbFAwclh5LzVzd3pDUGJtQlFUYUdJMlBS?=
 =?utf-8?B?cVJ3VUVHSk8wRnQ2UEsraEFuRy9nKzRxSzlqSUtvRFExMFg4OGRrb0hHSHNP?=
 =?utf-8?B?RnBBbjlFaHR6Sy81Y2I1RzJDbVlIdXFwZTRiV1FtdlpMMVNLNzQwVEQ1MW4r?=
 =?utf-8?B?NUwrcktWa2xJVGVyamZndU5nalNKcWRlZVIreFlyREVVOTJESjBjVFVuL01G?=
 =?utf-8?B?RkpiaEtMZ3o0aDNGbUF0VVJwbnVpSkNKRFF6eHorMTFMci9LWWpWZk9nd296?=
 =?utf-8?B?WWZwK3RSYWwvZkxjd2tRaUh6aWhJOFBIK1dKbFdDTnM2R0pWaTBwY1hYNm9K?=
 =?utf-8?B?UldyNFVRWXc5MFFrUEozYXpCZnlBYVlDNXBMQlA1bHEvcjFtOEQ5eWhRaEx6?=
 =?utf-8?B?QzNERmlJU3hlNjRJSHJiZDl4SnNYOXJSTEFmdnpZV1ZpeEhWN0o3RlRKakRR?=
 =?utf-8?B?a1ozQnFldWF5ck4xUDZiZ21CcmlhMTViTHFzdmgrcnVmQWhCbUFjRHZSTjFF?=
 =?utf-8?B?MnNwMDdLNGhZcGd1b0pNcDM4VUhzbmVwOWFXenBRMlN0VWN1cDRTY055ZHBa?=
 =?utf-8?B?MTVaWVU4bnh5emxTMEVRU2U2Q0VqUjcySStYVGliS0FCdC9id2didGQrWWFJ?=
 =?utf-8?B?eTlMZCtCaUhzUTBxNDBwN3RjVW5wWlhwMTZhTWNlaFh6cUtNZTZXM3RYeHVP?=
 =?utf-8?B?MkVjcDE5TGxVVFRycCs1S2lja01xaVFMYnFrbU0wVlFpVy9HSE54THFkSFE2?=
 =?utf-8?B?UTBjSE1iRHBVZnh4UkxIR1Y4S1hZMU5rVm5OeklyRDRSV3dRaXlVVE1TUThz?=
 =?utf-8?B?a2prVERDd1I4WW8rVUFJNmxibXFtc3NHNlRoQ3pXVnNjQVNldEllblJmSXFj?=
 =?utf-8?B?V2tuODNXemVVWitiMmttMTlLS1Z2d05WN0QxTzZsYXRMNytMekhtM1pvUTBs?=
 =?utf-8?B?d0xhUWZUV1E4bFdOOXJ3U3ZTaTlJeXp2M3ZSbHc2VUZ2dTR5RUxlNFE2bDRL?=
 =?utf-8?B?ZDZ0cHY3SVc3WEFiT1BGamRDaTN6Ny9rL2xxMXFCcHowOElMdmxIL0ZNZ1dX?=
 =?utf-8?B?VDJuNGtHay82VXFGVXl1a1RkaGxOY2RaOXRkWThqNEx2UXFXSk5EVktnMy8v?=
 =?utf-8?B?Sy9UNHAvQk9xYS9DMVNWMW5zNlFYNXBNVSt2YUl1cDROd1Fuc0NDODZHL3p4?=
 =?utf-8?B?eDRrWVhpc1ZnWWd6ZUNKSisxNnJocXlrcksxdlVkclJKaGhWOVY1bTNJTHJu?=
 =?utf-8?B?NmkxUVl3Y0t4UjFNRG1nTExJUU5LdERQbjdyVGZKWTBxT0w4TlhzS3AyWEdH?=
 =?utf-8?B?STN4S0NzMFdHNHRCY0Vta1Nkb3dkcXB5QXNLUjdXcE12UHhRcGdHZkdIQURG?=
 =?utf-8?B?VnRERytaOHlZWkh5UnpaUzFVQzFUOWMwSDZJZFY1dHdxaDR5eDNoSTVzbGcv?=
 =?utf-8?B?S1dRYlpaTmRFRDNqTTdLUGsvaVBySWRoZGgzQmRQTzN4QkI2a2swRGFOcmxz?=
 =?utf-8?B?cVYrb1Q3YVJqdmdobUpoTWNiTlN0QUlhNEJlQjd0QUJqdk9kbkxMRTkrYmg1?=
 =?utf-8?B?RW9VUU5RRzN0UHlMYm1LNUZOeTdOblVuZ3hYR2FzaHJBRmcrakswTWhiWGk5?=
 =?utf-8?B?MkRsL3pNL0svdG5OV1FHVC9yVVVYcTZqTyt6R0tlb2k3L1VRNnNWT0Z0bnll?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf6b4ad-3764-4cb8-03b5-08db98018a74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:20:59.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnVpPxIWD9JL5CgZjiJCp1/IKYaa9dLN+e5+wGHXjQc/DbU2Gvkv705gp0QH0dndinaABfnRW6iC++Djnpj+Z1cd2QTFXeJjUZuBDusY3lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/31/23 09:17, Joel Granados wrote:
> Move from register_net_sysctl to register_net_sysctl_sz for all the
> networking related files. Do this while making sure to mirror the NULL
> assignments with a table_size of zero for the unprivileged users.
> 
> We need to move to the new function in preparation for when we change
> SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro. Failing to do
> so would erroneously allow ARRAY_SIZE() to be called on a pointer. We
> hold off the SIZE_MAX to ARRAY_SIZE change until we have migrated all
> the relevant net sysctl registering functions to register_net_sysctl_sz
> in subsequent commits.
> 
> An additional size function was added to the following files in order to
> calculate the size of an array that is defined in another file:
>      include/net/ipv6.h
>      net/ipv6/icmp.c
>      net/ipv6/route.c
>      net/ipv6/sysctl_net_ipv6.c
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>   include/net/ipv6.h                  |  2 ++
>   net/core/neighbour.c                |  8 ++++++--
>   net/core/sysctl_net_core.c          |  3 ++-
>   net/ieee802154/6lowpan/reassembly.c |  8 ++++++--
>   net/ipv4/devinet.c                  |  3 ++-
>   net/ipv4/ip_fragment.c              |  3 ++-
>   net/ipv4/route.c                    |  8 ++++++--
>   net/ipv4/sysctl_net_ipv4.c          |  3 ++-
>   net/ipv4/xfrm4_policy.c             |  3 ++-
>   net/ipv6/addrconf.c                 |  3 ++-
>   net/ipv6/icmp.c                     |  5 +++++
>   net/ipv6/reassembly.c               |  3 ++-
>   net/ipv6/route.c                    | 13 +++++++++----
>   net/ipv6/sysctl_net_ipv6.c          | 16 +++++++++++-----
>   net/ipv6/xfrm6_policy.c             |  3 ++-
>   net/mpls/af_mpls.c                  |  6 ++++--
>   net/mptcp/ctrl.c                    |  3 ++-
>   net/rds/tcp.c                       |  3 ++-
>   net/sctp/sysctl.c                   |  4 +++-
>   net/smc/smc_sysctl.c                |  3 ++-
>   net/unix/sysctl_net_unix.c          |  3 ++-
>   net/xfrm/xfrm_sysctl.c              |  8 ++++++--
>   22 files changed, 82 insertions(+), 32 deletions(-)
> 
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 7332296eca44..63ba68536a20 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -1274,7 +1274,9 @@ static inline int snmp6_unregister_dev(struct inet6_dev *idev) { return 0; }
>   
>   #ifdef CONFIG_SYSCTL
>   struct ctl_table *ipv6_icmp_sysctl_init(struct net *net);
> +size_t ipv6_icmp_sysctl_table_size(void);
>   struct ctl_table *ipv6_route_sysctl_init(struct net *net);
> +size_t ipv6_route_sysctl_table_size(struct net *net);
>   int ipv6_sysctl_register(void);
>   void ipv6_sysctl_unregister(void);
>   #endif
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index ddd0f32de20e..adc7fc4ff9bf 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3779,6 +3779,7 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>   	const char *dev_name_source;
>   	char neigh_path[ sizeof("net//neigh/") + IFNAMSIZ + IFNAMSIZ ];
>   	char *p_name;
> +	size_t neigh_vars_size;
>   
>   	t = kmemdup(&neigh_sysctl_template, sizeof(*t), GFP_KERNEL_ACCOUNT);
>   	if (!t)
> @@ -3790,11 +3791,13 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>   		t->neigh_vars[i].extra2 = p;
>   	}
>   
> +	neigh_vars_size = ARRAY_SIZE(t->neigh_vars);
>   	if (dev) {
>   		dev_name_source = dev->name;
>   		/* Terminate the table early */
>   		memset(&t->neigh_vars[NEIGH_VAR_GC_INTERVAL], 0,
>   		       sizeof(t->neigh_vars[NEIGH_VAR_GC_INTERVAL]));
> +		neigh_vars_size = NEIGH_VAR_BASE_REACHABLE_TIME_MS;

%NEIGH_VAR_BASE_REACHABLE_TIME_MS is last usable index here, and since 
those are 0 based, size is one more, %NEIGH_VAR_GC_INTERVAL.
(spelling it "NEIGH_VAR_BASE_REACHABLE_TIME_MS+1" would be perhaps better?)

>   	} else {
>   		struct neigh_table *tbl = p->tbl;
>   		dev_name_source = "default";
> @@ -3841,8 +3844,9 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>   
>   	snprintf(neigh_path, sizeof(neigh_path), "net/%s/neigh/%s",
>   		p_name, dev_name_source);
> -	t->sysctl_header =
> -		register_net_sysctl(neigh_parms_net(p), neigh_path, t->neigh_vars);
> +	t->sysctl_header = register_net_sysctl_sz(neigh_parms_net(p),
> +						  neigh_path, t->neigh_vars,
> +						  neigh_vars_size);
>   	if (!t->sysctl_header)
>   		goto free;
>   
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 782273bb93c2..03f1edb948d7 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -712,7 +712,8 @@ static __net_init int sysctl_core_net_init(struct net *net)
>   			tmp->data += (char *)net - (char *)&init_net;
>   	}
>   
> -	net->core.sysctl_hdr = register_net_sysctl(net, "net/core", tbl);
> +	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl,
> +						      ARRAY_SIZE(netns_core_table));
>   	if (net->core.sysctl_hdr == NULL)
>   		goto err_reg;
>   
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index a91283d1e5bf..6dd960ec558c 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -360,6 +360,7 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
>   	struct ctl_table_header *hdr;
>   	struct netns_ieee802154_lowpan *ieee802154_lowpan =
>   		net_ieee802154_lowpan(net);
> +	size_t table_size = ARRAY_SIZE(lowpan_frags_ns_ctl_table);
>   
>   	table = lowpan_frags_ns_ctl_table;
>   	if (!net_eq(net, &init_net)) {
> @@ -369,8 +370,10 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
>   			goto err_alloc;
>   
>   		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> +		if (net->user_ns != &init_user_ns) {
>   			table[0].procname = NULL;
> +			table_size = 0;
> +		}
>   	}
>   
>   	table[0].data	= &ieee802154_lowpan->fqdir->high_thresh;
> @@ -379,7 +382,8 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
>   	table[1].extra2	= &ieee802154_lowpan->fqdir->high_thresh;
>   	table[2].data	= &ieee802154_lowpan->fqdir->timeout;
>   
> -	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table);
> +	hdr = register_net_sysctl_sz(net, "net/ieee802154/6lowpan", table,
> +				     table_size);
>   	if (hdr == NULL)
>   		goto err_reg;
>   
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 5deac0517ef7..89087844ea6e 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2720,7 +2720,8 @@ static __net_init int devinet_init_net(struct net *net)
>   		goto err_reg_dflt;
>   
>   	err = -ENOMEM;
> -	forw_hdr = register_net_sysctl(net, "net/ipv4", tbl);
> +	forw_hdr = register_net_sysctl_sz(net, "net/ipv4", tbl,
> +					  ARRAY_SIZE(ctl_forward_entry));
>   	if (!forw_hdr)
>   		goto err_reg_ctl;
>   	net->ipv4.forw_hdr = forw_hdr;
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index 69c00ffdcf3e..a4941f53b523 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -615,7 +615,8 @@ static int __net_init ip4_frags_ns_ctl_register(struct net *net)
>   	table[2].data	= &net->ipv4.fqdir->timeout;
>   	table[3].data	= &net->ipv4.fqdir->max_dist;
>   
> -	hdr = register_net_sysctl(net, "net/ipv4", table);
> +	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
> +				     ARRAY_SIZE(ip4_frags_ns_ctl_table));
>   	if (!hdr)
>   		goto err_reg;
>   
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 98d7e6ba7493..e7e9fba0357a 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -3592,6 +3592,7 @@ static struct ctl_table ipv4_route_netns_table[] = {
>   static __net_init int sysctl_route_net_init(struct net *net)
>   {
>   	struct ctl_table *tbl;
> +	size_t table_size = ARRAY_SIZE(ipv4_route_netns_table);
>   
>   	tbl = ipv4_route_netns_table;
>   	if (!net_eq(net, &init_net)) {
> @@ -3603,8 +3604,10 @@ static __net_init int sysctl_route_net_init(struct net *net)
>   
>   		/* Don't export non-whitelisted sysctls to unprivileged users */
>   		if (net->user_ns != &init_user_ns) {
> -			if (tbl[0].procname != ipv4_route_flush_procname)
> +			if (tbl[0].procname != ipv4_route_flush_procname) {
>   				tbl[0].procname = NULL;
> +				table_size = 0;
> +			}
>   		}
>   
>   		/* Update the variables to point into the current struct net
> @@ -3615,7 +3618,8 @@ static __net_init int sysctl_route_net_init(struct net *net)
>   	}
>   	tbl[0].extra1 = net;
>   
> -	net->ipv4.route_hdr = register_net_sysctl(net, "net/ipv4/route", tbl);
> +	net->ipv4.route_hdr = register_net_sysctl_sz(net, "net/ipv4/route",
> +						     tbl, table_size);
>   	if (!net->ipv4.route_hdr)
>   		goto err_reg;
>   	return 0;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 2afb0870648b..6ac890b4073f 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1519,7 +1519,8 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
>   		}
>   	}
>   
> -	net->ipv4.ipv4_hdr = register_net_sysctl(net, "net/ipv4", table);
> +	net->ipv4.ipv4_hdr = register_net_sysctl_sz(net, "net/ipv4", table,
> +						    ARRAY_SIZE(ipv4_net_table));
>   	if (!net->ipv4.ipv4_hdr)
>   		goto err_reg;
>   
> diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
> index 9403bbaf1b61..57ea394ffa8c 100644
> --- a/net/ipv4/xfrm4_policy.c
> +++ b/net/ipv4/xfrm4_policy.c
> @@ -178,7 +178,8 @@ static __net_init int xfrm4_net_sysctl_init(struct net *net)
>   		table[0].data = &net->xfrm.xfrm4_dst_ops.gc_thresh;
>   	}
>   
> -	hdr = register_net_sysctl(net, "net/ipv4", table);
> +	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
> +				     ARRAY_SIZE(xfrm4_policy_table));
>   	if (!hdr)
>   		goto err_reg;
>   
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index e5213e598a04..d615a84965c2 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7085,7 +7085,8 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
>   
>   	snprintf(path, sizeof(path), "net/ipv6/conf/%s", dev_name);
>   
> -	p->sysctl_header = register_net_sysctl(net, path, table);
> +	p->sysctl_header = register_net_sysctl_sz(net, path, table,
> +						  ARRAY_SIZE(addrconf_sysctl));
>   	if (!p->sysctl_header)
>   		goto free;
>   
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 65fa5014bc85..a76b01b41b57 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -1229,4 +1229,9 @@ struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
>   	}
>   	return table;
>   }
> +
> +size_t ipv6_icmp_sysctl_table_size(void)
> +{
> +	return ARRAY_SIZE(ipv6_icmp_table_template);
> +}
>   #endif
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index 5bc8a28e67f9..5ebc47da1000 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -470,7 +470,8 @@ static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
>   	table[1].extra2	= &net->ipv6.fqdir->high_thresh;
>   	table[2].data	= &net->ipv6.fqdir->timeout;
>   
> -	hdr = register_net_sysctl(net, "net/ipv6", table);
> +	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
> +				     ARRAY_SIZE(ip6_frags_ns_ctl_table));
>   	if (!hdr)
>   		goto err_reg;
>   
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 64e873f5895f..51c6cdae8723 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6447,14 +6447,19 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
>   		table[8].data = &net->ipv6.sysctl.ip6_rt_min_advmss;
>   		table[9].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
>   		table[10].data = &net->ipv6.sysctl.skip_notify_on_dev_down;
> -
> -		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> -			table[1].procname = NULL;
>   	}
>   
>   	return table;
>   }
> +
> +size_t ipv6_route_sysctl_table_size(struct net *net)
> +{
> +	/* Don't export sysctls to unprivileged users */
> +	if (net->user_ns != &init_user_ns)
> +		return 0;
> +
> +	return ARRAY_SIZE(ipv6_route_table_template);
> +}
>   #endif
>   
>   static int __net_init ip6_route_net_init(struct net *net)
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 94a0a294c6a1..888676163e90 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -275,17 +275,23 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
>   	if (!ipv6_icmp_table)
>   		goto out_ipv6_route_table;
>   
> -	net->ipv6.sysctl.hdr = register_net_sysctl(net, "net/ipv6", ipv6_table);
> +	net->ipv6.sysctl.hdr = register_net_sysctl_sz(net, "net/ipv6",
> +						      ipv6_table,
> +						      ARRAY_SIZE(ipv6_table_template));
>   	if (!net->ipv6.sysctl.hdr)
>   		goto out_ipv6_icmp_table;
>   
> -	net->ipv6.sysctl.route_hdr =
> -		register_net_sysctl(net, "net/ipv6/route", ipv6_route_table);
> +	net->ipv6.sysctl.route_hdr = register_net_sysctl_sz(net,
> +							    "net/ipv6/route",
> +							    ipv6_route_table,
> +							    ipv6_route_sysctl_table_size(net));
>   	if (!net->ipv6.sysctl.route_hdr)
>   		goto out_unregister_ipv6_table;
>   
> -	net->ipv6.sysctl.icmp_hdr =
> -		register_net_sysctl(net, "net/ipv6/icmp", ipv6_icmp_table);
> +	net->ipv6.sysctl.icmp_hdr = register_net_sysctl_sz(net,
> +							   "net/ipv6/icmp",
> +							   ipv6_icmp_table,
> +							   ipv6_icmp_sysctl_table_size());
>   	if (!net->ipv6.sysctl.icmp_hdr)
>   		goto out_unregister_route_table;
>   
> diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> index eecc5e59da17..8f931e46b460 100644
> --- a/net/ipv6/xfrm6_policy.c
> +++ b/net/ipv6/xfrm6_policy.c
> @@ -205,7 +205,8 @@ static int __net_init xfrm6_net_sysctl_init(struct net *net)
>   		table[0].data = &net->xfrm.xfrm6_dst_ops.gc_thresh;
>   	}
>   
> -	hdr = register_net_sysctl(net, "net/ipv6", table);
> +	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
> +				     ARRAY_SIZE(xfrm6_policy_table));
>   	if (!hdr)
>   		goto err_reg;
>   
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index bf6e81d56263..1af29af65388 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -1419,7 +1419,8 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
>   
>   	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
>   
> -	mdev->sysctl = register_net_sysctl(net, path, table);
> +	mdev->sysctl = register_net_sysctl_sz(net, path, table,
> +					      ARRAY_SIZE(mpls_dev_table));
>   	if (!mdev->sysctl)
>   		goto free;
>   
> @@ -2689,7 +2690,8 @@ static int mpls_net_init(struct net *net)
>   	for (i = 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
>   		table[i].data = (char *)net + (uintptr_t)table[i].data;
>   
> -	net->mpls.ctl = register_net_sysctl(net, "net/mpls", table);
> +	net->mpls.ctl = register_net_sysctl_sz(net, "net/mpls", table,
> +					       ARRAY_SIZE(mpls_table));
>   	if (net->mpls.ctl == NULL) {
>   		kfree(table);
>   		return -ENOMEM;
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index ae20b7d92e28..43e540328a52 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -150,7 +150,8 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>   	table[4].data = &pernet->stale_loss_cnt;
>   	table[5].data = &pernet->pm_type;
>   
> -	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> +	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
> +				     ARRAY_SIZE(mptcp_sysctl_table));
>   	if (!hdr)
>   		goto err_reg;
>   
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index c5b86066ff66..2dba7505b414 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -565,7 +565,8 @@ static __net_init int rds_tcp_init_net(struct net *net)
>   	}
>   	tbl[RDS_TCP_SNDBUF].data = &rtn->sndbuf_size;
>   	tbl[RDS_TCP_RCVBUF].data = &rtn->rcvbuf_size;
> -	rtn->rds_tcp_sysctl = register_net_sysctl(net, "net/rds/tcp", tbl);
> +	rtn->rds_tcp_sysctl = register_net_sysctl_sz(net, "net/rds/tcp", tbl,
> +						     ARRAY_SIZE(rds_tcp_sysctl_table));
>   	if (!rtn->rds_tcp_sysctl) {
>   		pr_warn("could not register sysctl\n");
>   		err = -ENOMEM;
> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index a7a9136198fd..f65d6f92afcb 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -612,7 +612,9 @@ int sctp_sysctl_net_register(struct net *net)
>   	table[SCTP_PF_RETRANS_IDX].extra2 = &net->sctp.ps_retrans;
>   	table[SCTP_PS_RETRANS_IDX].extra1 = &net->sctp.pf_retrans;
>   
> -	net->sctp.sysctl_header = register_net_sysctl(net, "net/sctp", table);
> +	net->sctp.sysctl_header = register_net_sysctl_sz(net, "net/sctp",
> +							 table,
> +							 ARRAY_SIZE(sctp_net_table));
>   	if (net->sctp.sysctl_header == NULL) {
>   		kfree(table);
>   		return -ENOMEM;
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index b6f79fabb9d3..3ab2d8eefc55 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -81,7 +81,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
>   			table[i].data += (void *)net - (void *)&init_net;
>   	}
>   
> -	net->smc.smc_hdr = register_net_sysctl(net, "net/smc", table);
> +	net->smc.smc_hdr = register_net_sysctl_sz(net, "net/smc", table,
> +						  ARRAY_SIZE(smc_table));
>   	if (!net->smc.smc_hdr)
>   		goto err_reg;
>   
> diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
> index 500129aa710c..3e84b31c355a 100644
> --- a/net/unix/sysctl_net_unix.c
> +++ b/net/unix/sysctl_net_unix.c
> @@ -36,7 +36,8 @@ int __net_init unix_sysctl_register(struct net *net)
>   		table[0].data = &net->unx.sysctl_max_dgram_qlen;
>   	}
>   
> -	net->unx.ctl = register_net_sysctl(net, "net/unix", table);
> +	net->unx.ctl = register_net_sysctl_sz(net, "net/unix", table,
> +					      ARRAY_SIZE(unix_table));
>   	if (net->unx.ctl == NULL)
>   		goto err_reg;
>   
> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
> index 0c6c5ef65f9d..7fdeafc838a7 100644
> --- a/net/xfrm/xfrm_sysctl.c
> +++ b/net/xfrm/xfrm_sysctl.c
> @@ -44,6 +44,7 @@ static struct ctl_table xfrm_table[] = {
>   int __net_init xfrm_sysctl_init(struct net *net)
>   {
>   	struct ctl_table *table;
> +	size_t table_size = ARRAY_SIZE(xfrm_table);
>   
>   	__xfrm_sysctl_init(net);
>   
> @@ -56,10 +57,13 @@ int __net_init xfrm_sysctl_init(struct net *net)
>   	table[3].data = &net->xfrm.sysctl_acq_expires;
>   
>   	/* Don't export sysctls to unprivileged users */
> -	if (net->user_ns != &init_user_ns)
> +	if (net->user_ns != &init_user_ns) {
>   		table[0].procname = NULL;

do we still have to set procname to NULL, even if passed size is 0?
(same thing for all earlier occurences)

> +		table_size = 0;
> +	}
>   
> -	net->xfrm.sysctl_hdr = register_net_sysctl(net, "net/core", table);
> +	net->xfrm.sysctl_hdr = register_net_sysctl_sz(net, "net/core", table,
> +						      table_size);
>   	if (!net->xfrm.sysctl_hdr)
>   		goto out_register;
>   	return 0;

overall this patch looks sane, and whole series looks very promissing, 
thanks
