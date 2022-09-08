Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD65B2920
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 00:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiIHWPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 18:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIHWPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:15:41 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150123.outbound.protection.outlook.com [40.107.15.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F292DB72AC;
        Thu,  8 Sep 2022 15:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNBE5/DvXBkUnumM3EZtkDBfjxP3Xhd1GXI7kKLshzNgB1vgvWhsY1c9VgZIF1CPN8LU9NgFhQDotXSiYe4I5xgLW/31EI9wDofyv/JqjbyWg11N6mzzFJKioGZo5xIKH5WfyVMm7YCEzMd3yz0Ct/t4WQbR6m9zYc/9xh2YnxmuMjmbDaJcRSN+lCYb8XI/2+dJ4mlIcwcj7xAo3IUN3to3zdWGkw4hooNKD6Q0xyT/bMvosjJF4xPInpx3Jv+upCyR0qkwU+CKkmKaYHGSyTF1vhd4BOieOkRUzPOtA5sM6DOWn0s2GMiYAJTAYDEDy3HFgh2y5PvDkcRVewraCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGJXTARLSzBFZ7k0x944h78BPJ2meoCF2ULICEQODDo=;
 b=O7btXX/QGOOvXc/PK3ByX7U3ASZfl9dgPsUUyzKWkBzp7aarwO79RqQvJ43DeEJ5nLrNa0dgwPEuuOTdEC26lmZEESX9ycigGtqvazdU5sEiEgbx/X/mnxxEhIz3EZX3zUGhFKOV1nJYWUdKiibPwZB3BqYkFNRtu5O2yrgAf22KD0xDGUMPUw8B9v6Tee2+Uv648XCseJf4l2CBoYi5yumZkJUDuGm4sU6gSosimFv5PMQzX2I0dWVmYUsy9mwz1+Rfkz4kwzG4isQIi3vUWxClp2456to/tWgx7ATaYD75cl0nzbNDZMoI7fpQ3S3v+TfT8CQ3Qddx+mVrk7FNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGJXTARLSzBFZ7k0x944h78BPJ2meoCF2ULICEQODDo=;
 b=cy4ttbqijWlLuijp9P6vv8ptiY6VZgjs3JnqRhVhToGWd3qWx7eczrJke8HBO6UYa7gIGhfx1iS5dEtb/1GUQn1ITxpdmKYjd89Lbd4mHtYcl1fQdEl1S+Kj3nM3eAg/o+r9+j3H76hEmjyh56uCQR4whNw3M+rHbk+V6pLJCumQjlAjMvUTy4ZNzxckCJPgrsCIcjM83vNci8gKYSwK8SwI44uQHDu4bU8jlPAeTO0p8dgOcX5dyZyfsnQ+HRYLU+RHToRvWAN6giL9DATFDaJAWkip/6NG/OtY2K8TNM9BGTyMnkTJKl35KMKknKxsg9PVy1eQGJ63KhupBn4bcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by DU0PR08MB8812.eurprd08.prod.outlook.com (2603:10a6:10:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 22:15:36 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 22:15:36 +0000
Message-ID: <5a09fae7-8430-9bca-b112-6d489b7d3e5b@virtuozzo.com>
Date:   Fri, 9 Sep 2022 01:15:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] Add CABA tree to task_struct
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ia64@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@openvz.org
References: <20220908140313.313020-2-ptikhomirov@virtuozzo.com>
 <202209090529.EL54HX2U-lkp@intel.com>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <202209090529.EL54HX2U-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0087.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::40) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|DU0PR08MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd21661-fbbb-47d1-e8ef-08da91e7a762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9HXenlHnl0sHV+n42CzGdlHh+eSR5XIB3YXCZHg4Gv9FDQ7KhqS1X9Xc8oz+cdslk6FcCrOTucbA+Na0BB6RFP3Hu+CWNV8q3C2Myz1C9yDYh6maGa7eBfomp4ZljpObqiXLZzUED8OcPj9WVlGLbibO5qsgAs9Gj2u0Beb7TqCHdLjrT7brPeBBfCAwkl4nnFi7e+cOqXfeBZLjCDb3uBWeabsmSTZ69d0volhOkeY9GR5J9jNrUJXtKP0IINIoamoqNVh4TfaKJQHPX0nDSepwMjYG5yvZLPwZyqu1NdXvlWcgsDoZakEHhuQj/BykP4f0ORbNJxDbnvzLW4TmMwRdIGMz+VZLCzqwdLvWCKDZXVnySHj4lZgShKwR5ZIMjfwAt5J3cEKQrPuoL0g4Ded5cw/NSm2bPPIUqrUdQxXAuWpaxd1n8EzvYSiTo+mfhyrhKbY0ISZ8/JKmW4MrRYaJvPnyWy2OLPiMFxtOFbv8kPiRl2fzx/uItbL0vk4UXwnf0s3ERBwCoEPBbVaniJJ7B5eh2xlsuqCKVMGgIqOlfLr/PUtJsG0faUDz/Tojdl3M4hF/UH1vErgD2nCQGcahB94hmoaC9kw/u0Re8U4FGjkfheDKFtXktpen3RbeESt346Pgl/cq+LM3dMax2PLbQnFOruhjFHMahPTqfL2Zh69pxkxgAe7NrnKbVxjvlczbW/EXjTRomyDWZhZjYL40JPesNPo1Xz6a/PuLm5RuLmaM8rzNf5mK5PVWUT4TNBRoyL8Ry8D72mhS95oXi6QzsSB0T0teGHq4ze4F7hTU0CdN0OKxlwAUpV/kzGBndaQjPococtGnRK7Ma5JBm1H+girqSOn+LbmJJHFuHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(6512007)(66556008)(966005)(38100700002)(316002)(110136005)(31686004)(4326008)(478600001)(54906003)(66946007)(6486002)(66476007)(36756003)(83380400001)(8676002)(8936002)(107886003)(6666004)(41300700001)(86362001)(30864003)(31696002)(186003)(5660300002)(6506007)(53546011)(7416002)(2616005)(2906002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VKSXhGOTM2VGlGVHlUS0h1eTJISUlKQ2drSndTWVVGZitGYU1KUDhnVkZu?=
 =?utf-8?B?bEhBWTV5YWtINVFEUmhCc2E2OGpZSXlVUUoyMmFZa3pKYUNlazJtVUpLZG50?=
 =?utf-8?B?blUxcVVsQnlwSXlwS1A0Q3NCelVGUVYrSTlyQm1qbVA0b0JiNlg4ZmlSTndx?=
 =?utf-8?B?V1lTT1hFYUs3UkxmRCtaSDNBV2Q1QXhOTXpTdnJOc0dOZUp1NGFBR016REdF?=
 =?utf-8?B?RDJFRU5MMFVJRkFYTlB5Zm5UcjdYL2daM0c5TnlIbzlyZzd3TGVQYVNQaUtP?=
 =?utf-8?B?L2pMWFBGWG4wTGdreG5ZSUlBaVY4eDlCU3NlMjFaZEhiSWxhV285Ym14YURj?=
 =?utf-8?B?ZDJpeURIbFFmUFhyMk1SUDhGOExPb1JwLytqUG4vbWhrVWtYdmI1S3JwQkZr?=
 =?utf-8?B?a0MxMUducVhRV0VqYUk3bldhamRUNVk1YkdOeHFBMnJuaFo4a2l2UkpPMGVE?=
 =?utf-8?B?UGNRQ0cxakV2Qmk1MWJlWFNPejhRYkw4aURHcjJiOEw3TTdFME5LbEQ4YjBX?=
 =?utf-8?B?dTVYZ1ZnSTBDUHBZOVBYTUdFVGtSQUNGMndSeE5yVG9VejF1dmNLWm0xbDFO?=
 =?utf-8?B?VXNYWGFZbTNpbVFOTXlpVnE4ZzJiU2RrckFadGpPcGdzQi9LZ25sWGgrUDdP?=
 =?utf-8?B?SW9hb2d4dm5SdDh4alVVSWxEeGNwSUdSVm9IbGl2VktwVFNmUEpaL2F0QWFi?=
 =?utf-8?B?Szhzc2loM0V5c2lqbEZMRlFGcmpJQlk4aFd5WVFjdlhzUmVXTWY1Tjd0Vncv?=
 =?utf-8?B?R3FuUS90ejNQNmxHcHY2bWx0WUcvaHloMXNRNmM2MmZnRjdZbDJxN2pNUTNu?=
 =?utf-8?B?cGp1MGhnWCtkdFhvaEFvOFJHR1QvRkdqUGxMUVdvd3cvZG9vSnFtVFlrb1h1?=
 =?utf-8?B?RGhUaFpBeWhNRitmdGtBNHhERmsrRFZxN0FZRzBjdmlZL1Y3Y3hlYS9zQXJm?=
 =?utf-8?B?amxaVWZ2TU9vOWJxOWk1bUxtUzY4bkVZVVM4S2tSaGkxUXczZ1RoMGkyWHlm?=
 =?utf-8?B?dUd6VVNhQkpEZlpLLzIrVENwWUYyeDhXT0IrQjl1YVJDMjVPbVlrTjI1c0R5?=
 =?utf-8?B?SEZJdGtTb2MzY3p4YmdjNk9xVDlXLzJjUTdJdjdxL3hDK2lEcUhJVlQ5dGtK?=
 =?utf-8?B?aW1XTWc1YnZhMmNIcmZtWk1wRXRQZWJPdnVVZnFLMGVBeFlKTHlMZ3ZsQXQr?=
 =?utf-8?B?NTV2MUlXaTJvS3FUdllCSC8veFZPYVFhNStlaFVJdDN1bXBaOWxoaFVoUTlN?=
 =?utf-8?B?NHRscnhBYmFhUHl4R3ppNFIydG5XQkp3bm1UVS9Gd2MzNUZpVUZWYjJUV2F0?=
 =?utf-8?B?RnVoU3NHT1FkZzlmdlN1THA5TUxtZTUwWWQzMmp3eEsvT2J4b3JSTUdDeXVh?=
 =?utf-8?B?NkYxcFNMY09VS0hGZnZRcTlKVDBOT2ExRTZ0T1RzbWFoWmJINzhvTCtIYy8r?=
 =?utf-8?B?RG0zeE8xS3dOcGxYWW5NVDdkY25nY0xZSmc5cWU3UkNwZ1kvWEFZMXBackYr?=
 =?utf-8?B?Z1BMMnBsSWlJTFFzZVdXakVnVkVyQjR3Zm1jSmtHMWZMd3dPdDd3S2MxckR4?=
 =?utf-8?B?K3JFdGhFMlQ0OCtkaklScXRzKzJycWZRUnJ4SEk0YVI1RHNVZTg1NlJLNEUx?=
 =?utf-8?B?UHdMRmJ2WGM0RDdxSjJVK1BadFNRcHk1dkIyaHo5NktCenhQWXRRK1dtRlVD?=
 =?utf-8?B?c2N1ZWFRaHJFKzhmNWJ2cDRqQW1jdU1JNFIyTFRsdVlUVnJ6YW5VNjhOZTg1?=
 =?utf-8?B?TXdsa3ZZaU1DbG1JUWtYSnk2dGNLT0FsaXdkTncvdEI0OGppb3ZEdHk1cnJx?=
 =?utf-8?B?SzVDZFpVMHY4V2I4cFQxcXNpbWhtMVBpa29WODFMTXR0SCtwWTNFdkFseTVU?=
 =?utf-8?B?Um9vRjNGcCtsRTRLeFdWL3ZnNzhWK3dGTXZ5VFdDRVlqRlIwK1F3MFNtVXRs?=
 =?utf-8?B?dHBTeHQ5NmZqVTNEeXRRNzU4SDRuVmllbnE1TnFDK2RQd1dCUjlaWnNBODZs?=
 =?utf-8?B?NEpXaUxNMlNLNHE1RU1nVFZoZSs0NGR3L3pNc09YVmRmNWtET0p5bzBocHAw?=
 =?utf-8?B?Q000bTJremhZUTE5cS8raVVTeE11U0t6eTJNSUZ3N2dMVFpPTFpRRkY2Rm81?=
 =?utf-8?B?a3RKOE5PdGY4dFU4UlJqKzFFWXh3cGIva0dSTUJITlA4RXY1TFFHSmRKMzNn?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd21661-fbbb-47d1-e8ef-08da91e7a762
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:15:35.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtUJ8sHLqJWAvV32T0JdavUPerzdYGEtxruDV2laeMfFYBsc/2zLwJ07PKUG0EnUoqvwb4N/EypSXAJi7a02jbfIiIv7apJgGJlzIVMFYuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8812
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 09.09.2022 00:29, kernel test robot wrote:
> Hi Pavel,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on shuah-kselftest/next]
> [also build test WARNING on kees/for-next/execve tip/sched/core linus/master v6.0-rc4 next-20220908]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/Introduce-CABA-helper-process-tree/20220908-220639
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
> config: s390-randconfig-s043-20220907 (https://download.01.org/0day-ci/archive/20220909/202209090529.EL54HX2U-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-39-gce1a6720-dirty
>          # https://github.com/intel-lab-lkp/linux/commit/17a897a33137d4f49f99c8be8d619f6f711fccdb
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Pavel-Tikhomirov/Introduce-CABA-helper-process-tree/20220908-220639
>          git checkout 17a897a33137d4f49f99c8be8d619f6f711fccdb
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
>     kernel/fork.c:1307:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
>     kernel/fork.c:1307:22: sparse:     expected struct file *[assigned] old_exe_file
>     kernel/fork.c:1307:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
>     kernel/fork.c:1638:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
>     kernel/fork.c:1638:38: sparse:     expected struct refcount_struct [usertype] *r
>     kernel/fork.c:1638:38: sparse:     got struct refcount_struct [noderef] __rcu *
>     kernel/fork.c:1647:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:1647:31: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:1647:31: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:1648:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
>     kernel/fork.c:1648:9: sparse:     expected void const *
>     kernel/fork.c:1648:9: sparse:     got struct k_sigaction [noderef] __rcu *
>     kernel/fork.c:1648:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
>     kernel/fork.c:1648:9: sparse:     expected void const *
>     kernel/fork.c:1648:9: sparse:     got struct k_sigaction [noderef] __rcu *
>     kernel/fork.c:1648:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
>     kernel/fork.c:1648:9: sparse:     expected void const *
>     kernel/fork.c:1648:9: sparse:     got struct k_sigaction [noderef] __rcu *
>     kernel/fork.c:1649:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:1649:33: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:1649:33: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:1742:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *lp @@     got struct arch_spinlock_t [noderef] __rcu * @@
>     kernel/fork.c:1742:9: sparse:     expected struct arch_spinlock_t [usertype] *lp
>     kernel/fork.c:1742:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
>     kernel/fork.c:2077:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2077:31: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2077:31: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2081:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2081:33: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2081:33: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2403:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
>     kernel/fork.c:2403:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
>     kernel/fork.c:2403:32: sparse:     got struct task_struct *
>>> kernel/fork.c:2407:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *caba @@     got struct task_struct * @@
>     kernel/fork.c:2407:17: sparse:     expected struct task_struct [noderef] __rcu *caba
>     kernel/fork.c:2407:17: sparse:     got struct task_struct *
>     kernel/fork.c:2413:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2413:27: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2413:27: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2460:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
>     kernel/fork.c:2460:54: sparse:     expected struct list_head *head
>     kernel/fork.c:2460:54: sparse:     got struct list_head [noderef] __rcu *
>     kernel/fork.c:2461:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
>     kernel/fork.c:2461:51: sparse:     expected struct list_head *head
>     kernel/fork.c:2461:51: sparse:     got struct list_head [noderef] __rcu *
>     kernel/fork.c:2482:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2482:29: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2482:29: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2503:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2503:29: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2503:29: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2530:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
>     kernel/fork.c:2530:28: sparse:     expected struct sighand_struct *sighand
>     kernel/fork.c:2530:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>     kernel/fork.c:2559:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2559:31: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2559:31: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2561:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2561:33: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2561:33: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2997:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
>     kernel/fork.c:2997:24: sparse:     expected struct task_struct *[assigned] parent
>     kernel/fork.c:2997:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     kernel/fork.c:3078:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
>     kernel/fork.c:3078:43: sparse:     expected struct refcount_struct const [usertype] *r
>     kernel/fork.c:3078:43: sparse:     got struct refcount_struct [noderef] __rcu *
>     kernel/fork.c:2122:22: sparse: sparse: dereference of noderef expression
>     kernel/fork.c: note: in included file (through arch/s390/include/asm/stacktrace.h, arch/s390/include/asm/perf_event.h, include/linux/perf_event.h, ...):
>     include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
>     include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
>     include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
>     include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
>     include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
>     include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
>     kernel/fork.c:2458:59: sparse: sparse: dereference of noderef expression
>     kernel/fork.c:2459:59: sparse: sparse: dereference of noderef expression
> --
>>> kernel/exit.c:84:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] new_caba @@     got struct task_struct [noderef] __rcu *caba @@
>     kernel/exit.c:84:26: sparse:     expected struct task_struct *[assigned] new_caba
>     kernel/exit.c:84:26: sparse:     got struct task_struct [noderef] __rcu *caba
>     kernel/exit.c:302:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *real_parent @@
>     kernel/exit.c:302:37: sparse:     expected struct task_struct *tsk
>     kernel/exit.c:302:37: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     kernel/exit.c:305:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
>     kernel/exit.c:305:32: sparse:     expected struct task_struct *task
>     kernel/exit.c:305:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     kernel/exit.c:306:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
>     kernel/exit.c:306:35: sparse:     expected struct task_struct *task
>     kernel/exit.c:306:35: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     kernel/exit.c:351:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
>     kernel/exit.c:351:24: sparse:     expected struct task_struct *parent
>     kernel/exit.c:351:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     kernel/exit.c:378:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:378:27: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:378:27: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:381:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:381:29: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:381:29: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:604:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
>     kernel/exit.c:604:29: sparse:     expected struct task_struct *reaper
>     kernel/exit.c:604:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     kernel/exit.c:606:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
>     kernel/exit.c:606:29: sparse:     expected struct task_struct *reaper
>     kernel/exit.c:606:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     kernel/exit.c:930:63: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *const sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
>     kernel/exit.c:930:63: sparse:     expected struct sighand_struct *const sighand
>     kernel/exit.c:930:63: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>     kernel/exit.c:1085:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:1085:39: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:1085:39: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:1110:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:1110:41: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:1110:41: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:1199:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:1199:25: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:1199:25: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:1214:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:1214:27: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:1214:27: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:1265:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:1265:25: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:1265:25: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:1268:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:1268:35: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:1268:35: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:1274:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/exit.c:1274:27: sparse:     expected struct spinlock [usertype] *lock
>     kernel/exit.c:1274:27: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/exit.c:1455:59: sparse: sparse: incompatible types in comparison expression (different base types):
>     kernel/exit.c:1455:59: sparse:    void *
>     kernel/exit.c:1455:59: sparse:    struct task_struct [noderef] __rcu *
>     kernel/exit.c:1471:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu * @@
>     kernel/exit.c:1471:25: sparse:     expected struct task_struct *parent
>     kernel/exit.c:1471:25: sparse:     got struct task_struct [noderef] __rcu *
>     kernel/exit.c: note: in included file:
>     include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
>     include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
>     include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
>     include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
>     include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
>     include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
>     include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
>     include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
>     include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
>     include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
>     kernel/exit.c: note: in included file (through include/linux/sched/signal.h, include/linux/rcuwait.h, include/linux/percpu-rwsem.h, ...):
>     include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_zombie' - unexpected unlock
>     include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_stopped' - unexpected unlock
>     include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_continued' - unexpected unlock
>     kernel/exit.c: note: in included file:
>     include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
>     include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
>     include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
>     include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
>     include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
>     kernel/exit.c:1563:9: sparse: sparse: context imbalance in 'do_wait' - wrong count at exit
> --
>     init/init_task.c:107:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
>     init/init_task.c:107:28: sparse:     expected struct task_struct [noderef] __rcu *real_parent
>     init/init_task.c:107:28: sparse:     got struct task_struct *
>     init/init_task.c:108:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct * @@
>     init/init_task.c:108:28: sparse:     expected struct task_struct [noderef] __rcu *parent
>     init/init_task.c:108:28: sparse:     got struct task_struct *
>>> init/init_task.c:112:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct [noderef] __rcu *caba @@     got struct task_struct * @@
>     init/init_task.c:112:28: sparse:     expected struct task_struct [noderef] __rcu *caba
>     init/init_task.c:112:28: sparse:     got struct task_struct *
>     init/init_task.c:125:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct [noderef] __rcu *sighand @@     got struct sighand_struct * @@
>     init/init_task.c:125:28: sparse:     expected struct sighand_struct [noderef] __rcu *sighand
>     init/init_task.c:125:28: sparse:     got struct sighand_struct *
> 
> vim +2407 kernel/fork.c
> 
>    2355	
>    2356		/*
>    2357		 * Ensure that the cgroup subsystem policies allow the new process to be
>    2358		 * forked. It should be noted that the new process's css_set can be changed
>    2359		 * between here and cgroup_post_fork() if an organisation operation is in
>    2360		 * progress.
>    2361		 */
>    2362		retval = cgroup_can_fork(p, args);
>    2363		if (retval)
>    2364			goto bad_fork_put_pidfd;
>    2365	
>    2366		/*
>    2367		 * Now that the cgroups are pinned, re-clone the parent cgroup and put
>    2368		 * the new task on the correct runqueue. All this *before* the task
>    2369		 * becomes visible.
>    2370		 *
>    2371		 * This isn't part of ->can_fork() because while the re-cloning is
>    2372		 * cgroup specific, it unconditionally needs to place the task on a
>    2373		 * runqueue.
>    2374		 */
>    2375		sched_cgroup_fork(p, args);
>    2376	
>    2377		/*
>    2378		 * From this point on we must avoid any synchronous user-space
>    2379		 * communication until we take the tasklist-lock. In particular, we do
>    2380		 * not want user-space to be able to predict the process start-time by
>    2381		 * stalling fork(2) after we recorded the start_time but before it is
>    2382		 * visible to the system.
>    2383		 */
>    2384	
>    2385		p->start_time = ktime_get_ns();
>    2386		p->start_boottime = ktime_get_boottime_ns();
>    2387	
>    2388		/*
>    2389		 * Make it visible to the rest of the system, but dont wake it up yet.
>    2390		 * Need tasklist lock for parent etc handling!
>    2391		 */
>    2392		write_lock_irq(&tasklist_lock);
>    2393	
>    2394		/* CLONE_PARENT re-uses the old parent */
>    2395		if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
>    2396			p->real_parent = current->real_parent;
>    2397			p->parent_exec_id = current->parent_exec_id;
>    2398			if (clone_flags & CLONE_THREAD)
>    2399				p->exit_signal = -1;
>    2400			else
>    2401				p->exit_signal = current->group_leader->exit_signal;
>    2402		} else {
>    2403			p->real_parent = current;
>    2404			p->parent_exec_id = current->self_exec_id;
>    2405			p->exit_signal = args->exit_signal;
>    2406		}
>> 2407		p->caba = current;

Not sure how to fix this error, we set real_parent to current just 
several lines above, but as I want to set caba to current in 
CLONE_PARENT case to see actual parent after CLONE_PARENT calls, and I 
can't take it from real_parent which is different in this case.

Note that I've updated this patch to v4, as for threads creation caba = 
current was not a desired behaviour.

>    2408	
>    2409		klp_copy_process(p);
>    2410	
>    2411		sched_core_fork(p);
>    2412	
>    2413		spin_lock(&current->sighand->siglock);
>    2414	
>    2415		/*
>    2416		 * Copy seccomp details explicitly here, in case they were changed
>    2417		 * before holding sighand lock.
>    2418		 */
>    2419		copy_seccomp(p);
>    2420	
>    2421		rv_task_fork(p);
>    2422	
>    2423		rseq_fork(p, clone_flags);
>    2424	
>    2425		/* Don't start children in a dying pid namespace */
>    2426		if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
>    2427			retval = -ENOMEM;
>    2428			goto bad_fork_cancel_cgroup;
>    2429		}
>    2430	
>    2431		/* Let kill terminate clone/fork in the middle */
>    2432		if (fatal_signal_pending(current)) {
>    2433			retval = -EINTR;
>    2434			goto bad_fork_cancel_cgroup;
>    2435		}
>    2436	
>    2437		init_task_pid_links(p);
>    2438		if (likely(p->pid)) {
>    2439			ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
>    2440	
>    2441			init_task_pid(p, PIDTYPE_PID, pid);
>    2442			if (thread_group_leader(p)) {
>    2443				init_task_pid(p, PIDTYPE_TGID, pid);
>    2444				init_task_pid(p, PIDTYPE_PGID, task_pgrp(current));
>    2445				init_task_pid(p, PIDTYPE_SID, task_session(current));
>    2446	
>    2447				if (is_child_reaper(pid)) {
>    2448					ns_of_pid(pid)->child_reaper = p;
>    2449					p->signal->flags |= SIGNAL_UNKILLABLE;
>    2450				}
>    2451				p->signal->shared_pending.signal = delayed.signal;
>    2452				p->signal->tty = tty_kref_get(current->signal->tty);
>    2453				/*
>    2454				 * Inherit has_child_subreaper flag under the same
>    2455				 * tasklist_lock with adding child to the process tree
>    2456				 * for propagate_has_child_subreaper optimization.
>    2457				 */
>    2458				p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
>    2459								 p->real_parent->signal->is_child_subreaper;
>    2460				list_add_tail(&p->sibling, &p->real_parent->children);
>    2461				list_add_tail(&p->cabd, &p->caba->cabds);
>    2462				list_add_tail_rcu(&p->tasks, &init_task.tasks);
>    2463				attach_pid(p, PIDTYPE_TGID);
>    2464				attach_pid(p, PIDTYPE_PGID);
>    2465				attach_pid(p, PIDTYPE_SID);
>    2466				__this_cpu_inc(process_counts);
>    2467			} else {
>    2468				current->signal->nr_threads++;
>    2469				atomic_inc(&current->signal->live);
>    2470				refcount_inc(&current->signal->sigcnt);
>    2471				task_join_group_stop(p);
>    2472				list_add_tail_rcu(&p->thread_group,
>    2473						  &p->group_leader->thread_group);
>    2474				list_add_tail_rcu(&p->thread_node,
>    2475						  &p->signal->thread_head);
>    2476			}
>    2477			attach_pid(p, PIDTYPE_PID);
>    2478			nr_threads++;
>    2479		}
>    2480		total_forks++;
>    2481		hlist_del_init(&delayed.node);
>    2482		spin_unlock(&current->sighand->siglock);
>    2483		syscall_tracepoint_update(p);
>    2484		write_unlock_irq(&tasklist_lock);
>    2485	
>    2486		if (pidfile)
>    2487			fd_install(pidfd, pidfile);
>    2488	
>    2489		proc_fork_connector(p);
>    2490		sched_post_fork(p);
>    2491		cgroup_post_fork(p, args);
>    2492		perf_event_fork(p);
>    2493	
>    2494		trace_task_newtask(p, clone_flags);
>    2495		uprobe_copy_process(p, clone_flags);
>    2496	
>    2497		copy_oom_score_adj(clone_flags, p);
>    2498	
>    2499		return p;
>    2500	
>    2501	bad_fork_cancel_cgroup:
>    2502		sched_core_free(p);
>    2503		spin_unlock(&current->sighand->siglock);
>    2504		write_unlock_irq(&tasklist_lock);
>    2505		cgroup_cancel_fork(p, args);
>    2506	bad_fork_put_pidfd:
>    2507		if (clone_flags & CLONE_PIDFD) {
>    2508			fput(pidfile);
>    2509			put_unused_fd(pidfd);
>    2510		}
>    2511	bad_fork_free_pid:
>    2512		if (pid != &init_struct_pid)
>    2513			free_pid(pid);
>    2514	bad_fork_cleanup_thread:
>    2515		exit_thread(p);
>    2516	bad_fork_cleanup_io:
>    2517		if (p->io_context)
>    2518			exit_io_context(p);
>    2519	bad_fork_cleanup_namespaces:
>    2520		exit_task_namespaces(p);
>    2521	bad_fork_cleanup_mm:
>    2522		if (p->mm) {
>    2523			mm_clear_owner(p->mm, p);
>    2524			mmput(p->mm);
>    2525		}
>    2526	bad_fork_cleanup_signal:
>    2527		if (!(clone_flags & CLONE_THREAD))
>    2528			free_signal_struct(p->signal);
>    2529	bad_fork_cleanup_sighand:
>    2530		__cleanup_sighand(p->sighand);
>    2531	bad_fork_cleanup_fs:
>    2532		exit_fs(p); /* blocking */
>    2533	bad_fork_cleanup_files:
>    2534		exit_files(p); /* blocking */
>    2535	bad_fork_cleanup_semundo:
>    2536		exit_sem(p);
>    2537	bad_fork_cleanup_security:
>    2538		security_task_free(p);
>    2539	bad_fork_cleanup_audit:
>    2540		audit_free(p);
>    2541	bad_fork_cleanup_perf:
>    2542		perf_event_free_task(p);
>    2543	bad_fork_cleanup_policy:
>    2544		lockdep_free_task(p);
>    2545	#ifdef CONFIG_NUMA
>    2546		mpol_put(p->mempolicy);
>    2547	#endif
>    2548	bad_fork_cleanup_delayacct:
>    2549		delayacct_tsk_free(p);
>    2550	bad_fork_cleanup_count:
>    2551		dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>    2552		exit_creds(p);
>    2553	bad_fork_free:
>    2554		WRITE_ONCE(p->__state, TASK_DEAD);
>    2555		exit_task_stack_account(p);
>    2556		put_task_stack(p);
>    2557		delayed_free_task(p);
>    2558	fork_out:
>    2559		spin_lock_irq(&current->sighand->siglock);
>    2560		hlist_del_init(&delayed.node);
>    2561		spin_unlock_irq(&current->sighand->siglock);
>    2562		return ERR_PTR(retval);
>    2563	}
>    2564	
> 

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
