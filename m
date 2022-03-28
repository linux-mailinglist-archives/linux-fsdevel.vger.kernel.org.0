Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F84E97F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbiC1NXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 09:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbiC1NXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:23:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAAE46161;
        Mon, 28 Mar 2022 06:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWxMCkoREWV4898/sN/+q5ALBJlpxznX/iB5TDFRivCvA0PrxLWVtb0D04nvxqJibrWCsD9qF8Yv1kAn89CUCrSGUo0fKPUbWN8yiRxB/NiX6ebMgg5QjM2d2l5svqV+YPOsTvoI5Fu7RAnnwfoRwoLA05vjgYkPkfONXnkx+/C1faQFgOh3boIBAknwKwQmeG/7Khw4J5iOplQ8JjjbKV0d7Cp43t7Be+pOstaZEZuYlEAvdzeru9EfIxWSa4WIYki8EzKGQCbo402H+80CuoMdIWd6imqnczWGqhlAGoJBU/TJt5csMlsJpPpI9oGrAdfX+RS7U5pzd5tM8+JToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKy/GtJNrOUTGS39MK4bNU63VbCqcvgtxF3n20YVXDg=;
 b=ODV1at8+X4VFdBSXdTFoNohRShpiys5421H5ib5APvfME0FeT7qIUAOkvYWAmeVZIbZZmstBeLF2Y2HCDnZAqku/ta/v0AJtBidbS5EEd/zOhRMUX8oJ+o55npi3KQys2LB0gGe+hQx+gNyqj75A9djV8Mz1GFaXgPXmU8/MhUyqT9g+O7kTXymZQwWceiv0BircGV3tUr1O3ejiJl6QAC7Tss2CjYlpPCNuyaQGwFGiomFDT4C+SX3pJRT+iZY8a4ae+KakNI41/EhDFNufOHJVbD96imwSqZ6EN6IRc2MgXmt3ayB155ZZZP2onZPhEq5bg6pCXgWDo0QDp4dWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKy/GtJNrOUTGS39MK4bNU63VbCqcvgtxF3n20YVXDg=;
 b=gc4aq/Tosb9w8cY5XRz+Os99HlhTvGmsGyhHPq6K5xeONvYoaSxO3q4hIgAnzZ1VySSJRtrlas4Sz45aFpNobdTpMXAs85DgOwocSfcc4ToD1uvUdL4xu/OOnE5a6D8zEKVCTo7BA1PGuzRz7Ud/uoCCjyRbOnZ+jD3KhethnEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM6PR19MB3674.namprd19.prod.outlook.com (2603:10b6:5:14e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 13:21:36 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::7c8f:fda5:16fa:a104]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::7c8f:fda5:16fa:a104%4]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 13:21:35 +0000
Message-ID: <6ba14287-336d-cdcd-0d39-680f288ca776@ddn.com>
Date:   Mon, 28 Mar 2022 15:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Boaz Harrosh <boaz@plexistor.com>,
        Sagi Manole <sagim@netapp.com>
From:   Bernd Schubert <bschubert@ddn.com>
Subject: RFC fuse waitq latency
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::17) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e51e189d-eedf-41a9-51e3-08da10bde21d
X-MS-TrafficTypeDiagnostic: DM6PR19MB3674:EE_
X-Microsoft-Antispam-PRVS: <DM6PR19MB3674FE195B15986AF6CFCF00B51D9@DM6PR19MB3674.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1lUS8Hffa+k+V6RnYreuRSTx4swrSewsJCycSNJX1m6DCGTOABjqigvMyYn1gLiOxXxcqy0O7F4NYqWg80ZYHgapKHgomKoj0v34bT3EQ5SHEF99g9jX/NW7TWkY5Y5RcVsMY9Z3Wtq0vF4HXONfsEbF0nBVE+2bCdtjujT11VtykLwDQCMUA1dA4O88SNLaGenk+iNsI8Zt07mBBjZRTI7e/G6a0c1egjTLfJn94GHK/Q+jSFo8ZXnIDw/8QqQ6gJWHOoOBl5K9iO921J0kZ+qgIqKgYa7jDHZfJI9yJGRl3OFkoTq295ET6CA3LtGQnEE4w+wwJmiFBw+GRZLsy6uh8LDZ7tyOPqhy7pulYX3sJKt5FDQFxrGZEN72t0cMwC410ktq44CKh7dBBDO+Ini0gNRWz7JnFX3T4YC2nKTV6TRMdTk6Z7oXRnK/OSRFQAI23JvKoVKaySym6rITznpoezK9/XAk1/QFu4UCRprVS8GWCrfPKAI0BExDo7sWn9n/wwLTyVYr3GKYf9jgRshv3LeQcS2+f5QoGh5iq0mYUeqOqe5D5L/5hygPeVANIjjS68E5fsUNWIg8fzi+IMlNpnf3nXJd9pvSQH1RI5XnPneAWubvdGaZwq51+ETQg0CzwI0zKeeAjXW/kSJR2XnA9vRmPYidf3QpG5QlPaCAKhtubIiYD9U5ETfe+E338TQbIHW5gKyG4zap+6EIbbkdc+jE71Kc+zTeTgUMJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66946007)(2906002)(31686004)(3480700007)(6512007)(86362001)(316002)(508600001)(6506007)(2616005)(186003)(4326008)(110136005)(83380400001)(38100700002)(8936002)(6486002)(8676002)(31696002)(5660300002)(66476007)(6666004)(54906003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUx3M3crRzE4SXhMU0ZHVmVaVWpRVW40cHJyRHBuTTg2R0RSQjlyMTJscUdo?=
 =?utf-8?B?SFdQcXNQSE5vMlQycGhOY0xyN1ZtZHQySVFJTVVBM1libXFCS2oxZ2N5Rkxl?=
 =?utf-8?B?RkVrMW83UTFveWhGOEdIbkhhNTJIQWpxN0EzS3pNQWIwV2hIYS9CSGxiWTQv?=
 =?utf-8?B?dHpQakhVYlZJRjdITUdhOVdEd0JSd2RwVkpVbG1Ib1hZRFFLWnlNY2JJQnNx?=
 =?utf-8?B?S0NoSnBCYVBiTGUxS25UblM2Q2dXakVFT0YyNU5ZcUdYRCtVUCs4cEN3eFYw?=
 =?utf-8?B?WFlCV2hSNU14a1FySnRGaFdDcnhzNytJZ1R2YlgxRC9ML2haNkQ4TkNzWWlk?=
 =?utf-8?B?ejJSUG1lK0l0Q2Y0SjJObHNnQzlEU1JEYm9ua0tlcCtTRldsTC9XNTRXU2hL?=
 =?utf-8?B?SGJCcFhyb0V1Z1lmaXNwY29FT1Z5ekg4aXBGV1A3VE14TlZZZXQ1NCtjdFVh?=
 =?utf-8?B?VklTdjZiYVh4OHE5K25xN0ZuS08zUFcwMTlqTUJpZHI0akpCdWQwcmtyQk54?=
 =?utf-8?B?cU45c0RTaEdLV3ZKVlZXeVg2WDBRN0FBTDZmS2tyQWloTHRoRmltdk5nNXhX?=
 =?utf-8?B?YmRoWit1bjdRNU9vZnlXUzdHTjdDbFU1Q1I4VnNUODBOTVZFQXBVWWRjbThk?=
 =?utf-8?B?My93cXFnNmlma1g0MEVTS29Ld2phOTFyZEx4dGpKanFRL0RNaWZUTFJidnNW?=
 =?utf-8?B?KzJnNlRxR2NHWHRQaTlTQUlzOVIxMHVRVTBOR2lRSmdXNlpsa3FzZlNEK0h1?=
 =?utf-8?B?Q09sdkpNTy84b2FJNHFmR1ZHN01NVG12bEYrZnRQVG05Mndwazlhc2dBVHMv?=
 =?utf-8?B?VitibkZpT3oxYmhuUXlXS3NlOWVlamZkQ2FQbmdzbjdXbU9Ya1E4em1iU3VQ?=
 =?utf-8?B?TUZ5RzJycXVZcVVUOE85Y2ZBWXhLd0w3bk1WOEk5ZjlHSGtiNkd3eElEdzlZ?=
 =?utf-8?B?eDlKSzV1ZDF4Z0JpT0Y5T0dwYytJakZaeHk4RW9YaU5xVUJvMWdxaC9rYzVT?=
 =?utf-8?B?MjUzV0dweXhhNjNpWFhSWjhabGE3QWNuQ3lTZzRkckdrU0lEZ1pIb0tsS0NV?=
 =?utf-8?B?TlF4Ny9DaW1WNVBBa091Yy9Zb3VCZnBaYk9HKzZsMlJ6S3dKMDYweW9kZG9W?=
 =?utf-8?B?OS9LMmxoOFc2NUIzazNKOWxBTDdOemoxWFdXZktVNXRpVHRrZnB6ZUVGRmxB?=
 =?utf-8?B?Rkd5STZETnBER1o3TExITmpmY2sxcnY0MHkrYmw5TlR0ZHVja28yYThvLzA4?=
 =?utf-8?B?eldTV3N6eENYK2o0NGUxR09FUFZlWGI4UDF4RkdwS25PYzJqVlJSb1RCSWNk?=
 =?utf-8?B?cjJFNWFtcUMwcTIyKzVOQlBVbEd4V1Fwc3h6ZU8zcjRUMktiWTFIamdiNmVO?=
 =?utf-8?B?VVovOFpDNXI2b3NLekNHUHlaWUJVYlBmeGtOaUptMjVobDJFWk5aWmRpN25I?=
 =?utf-8?B?cHFrVVE2SzVGV3d5cncyT0MvUkUvei9RU0d3TzRpK1dpTFhkUEI5OUJNdS9I?=
 =?utf-8?B?Y1V6UDhYbFg1MzJnM3h2eEZWTkFQVWZvdmJMTi9CNXdUclNodEE3dnVmUE4r?=
 =?utf-8?B?bjF4WEU2czQva3NCclRFWkVoVE1Qd2ZsYnhmdUhsbzdFSjFFdWJBSHB5cWU4?=
 =?utf-8?B?enBPQzJrSmg2czExSjhsbFRUSXBxT1NYYWM3QnFsZmZ4Qm1QeVp3N0JndVZX?=
 =?utf-8?B?MkFieWhWMldDeTBseDA5QTNSV0hvWXZiQStYeUNzS09LSUxzUVRiNFpFTkN6?=
 =?utf-8?B?WkczR0lYbzVIL2ZPZ0lZME9acEQwakE1K3pmeGxjTUtoUVp1aGdRWGpzdi85?=
 =?utf-8?B?cWs4U2VRTXRiUjNiUUVGVnlZVUdsdTM3TFdDTVFkUGNZck5Mek9HazhVTDZB?=
 =?utf-8?B?SlpIcDNraDhmQUVIWGNreFV6YXRRZ2RwRVFTejJpNExHcEduWmZaL2FmWHIv?=
 =?utf-8?B?NXd3a1JoOUM4RkxGY0N4bTJvM3N2MGZpc3dPeTlnN1FwNTcxc2dNdmFIQjkw?=
 =?utf-8?B?WGlKK2pKK1NNOFI0dm1yMTljUzJvaHIzcjN6bllxMnVRa3A4U3FORitBSFZY?=
 =?utf-8?B?RVpiajJSOTJmWnd3enZET0R2aHpmSHRhNGRzdlprWjFIQnhmaG92ZTUrK0tQ?=
 =?utf-8?B?SGJNZWJHNjF0RXZsTTdoK2c0dlAxQWNVWm5yaEVIL0NrU1I0Rkh2Qk9IUTYy?=
 =?utf-8?B?U0F1cUE5WjN2Q1V0YnY4WHlGVUdBRnROczdTWlV2UFNTeE9wOVlXY1pGVWRN?=
 =?utf-8?B?UDg1akRCUHhXSXJxbmRkWkYxWlQ0dTFmWHdqeVkvUVFDZno4eXNsaC9nRDMz?=
 =?utf-8?B?bGcrN2tVRWhnVmwrbE5JdXh2b3VHUHRlSE5sbGlUVlZWUjZvQ1RITHRqV0R5?=
 =?utf-8?Q?Z9Nz7v63a8KmEyzVm6kd3YoTnPszOuEdUFFuVyZh2aydS?=
X-MS-Exchange-AntiSpam-MessageData-1: S2rWb44FREiGmw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51e189d-eedf-41a9-51e3-08da10bde21d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:21:35.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mnp8hRhQy12Z5U9YyibZjEnz7zqTMzTFAtNaSXMX4J7NubtJ8GnHRWrYWmPe8wCqqs5I9o5SGP8lwy7M7W+a+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3674
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I would like to discuss the user thread wake up latency in
fuse_dev_do_read(). Profiling fuse shows there is room for improvement
regarding memory copies and splice. The basic profiling with flame graphs
didn't reveal, though, why fuse is so much
slower (with an overlay file system) than just accessing the underlying
file system directly and also didn't reveal why a single threaded fuse
uses less than 100% cpu, with the application on top of use also using
less than 100% cpu (simple bonnie++ runs with 1B files).
So I started to suspect the wait queues and indeed, keeping the thread
that reads the fuse device for work running for some time gives quite
some improvements.


diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 592730fd6e42..20b7cf296fb0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1034,7 +1034,7 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
  
  static int forget_pending(struct fuse_iqueue *fiq)
  {
-       return fiq->forget_list_head.next != NULL;
+       return READ_ONCE(fiq->forget_list_head.next) != NULL;
  }
  
  static int request_pending(struct fuse_iqueue *fiq)
@@ -1237,18 +1237,25 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
                 return -EINVAL;
  
   restart:
+       expires = jiffies + 10;
         for (;;) {
-               spin_lock(&fiq->lock);
-               if (!fiq->connected || request_pending(fiq))
-                       break;
-               spin_unlock(&fiq->lock);
  
+               if (!READ_ONCE(fiq->connected) || request_pending(fiq)) {
+                       spin_lock(&fiq->lock);
+                       if (!fiq->connected || request_pending(fiq))
+                               break;
+                       spin_unlock(&fiq->lock);
+               }
                 if (file->f_flags & O_NONBLOCK)
                         return -EAGAIN;
-               err = wait_event_interruptible_exclusive(fiq->waitq,
-                               !fiq->connected || request_pending(fiq));
+
+               if (time_after_eq(jiffies, expires))
+                       err = wait_event_interruptible_exclusive(fiq->waitq,
+                                       !fiq->connected || request_pending(fiq));
                 if (err)
                         return err;
+
+               cond_resched();
         }
  
         if (!fiq->connected) {



Without patch above

>                     ------Sequential Create------ --------Random Create--------
>                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>       files:max:min  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> imesrv1   30:1:1:10  5568  28  7784  40  9737  23  5756  29  5709  39  7573  25
> Latency             26813us     654us     965us     261us     550us     336ms



Patch above applied

                     ------Sequential Create------ --------Random Create--------
                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
       files:max:min  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
imesrv1   30:1:1:10  8043  30 12100  44 14024  22  7791  28  9238  43  9871  25
Latency               235us    3982us    3201us     240us     277us     355ms


So there is quite some improvement by 'just' preventing the thread going to
sleep, with the disadvantage that the thread now spins. This also does not
work that well when libfuse creates multiple threads (still with a single
threaded bonnie++), as wakeup then wakes up different threads, multiple
of them start to spin and without having profiled it, I guess
fiq->lock then might become a problem.

I had also tried to use swaitq instead of waitq, there is a little improvement
with it, but it does not solve the major issue.


Now if the wakeup is an issue, how did zufs avoid it? Looking at its code,
zufs also has a thread wakeup. Same for Miklos' fuse2. On our side
Dharmendra was just read to start to port Miklos' fuse2 to more recent
kernels and to add support into libfuse for it. Now with the waitq
latency we are not sure if this is actually the right approach.



Results above are done with bonnie++
bonnie++ -x 4 -q -s0  -d /scratch/dest/ -n 30:1:1:10 -r 0

using passthrough_hp. This is with additional patches (kernel side
has Dharmendras atomic-open optimizations, libfuse has additional
patches for atomic-open, a libfuse thread creation fix and more
fixes and options for passthrough_hp.cc).

passthrough_hp --foreground --nosplice --nocache --num_threads=1\
     /scratch/source /scratch/dest


Thanks,
Bernd

