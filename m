Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2111E3A3B20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 06:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFKEow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 00:44:52 -0400
Received: from mail-oln040092073071.outbound.protection.outlook.com ([40.92.73.71]:18175
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229562AbhFKEov (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 00:44:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKLwHww356GoQXmBiOmvLzZ9qHjjhILiGL0kTmfX2CuoWyTPugr1p642h87rWcolR86U2vnoXP+mbahKmw3g+uRdaudZBXf1r8GarmqpTwzbY6TpxrGS9eCa5evu8FM1jnn9mrTXld46EExS4STZfDQZhqhE2UrYlnr/vDiaj0PB5rHjyXHci2v1W8fBv4XoNXiTRM/VQDxLahdDkk47r/8QDLHu37KJ7LQe3R9s/BO3swHvxXy1nu5eEpQZG4UhqzjtTDTCjEkb/lIELmYZ77PAhmYkxBrtU84sXkQ375S5dZDk4YETVoB5vrIr5UjB2tDxafzcAc9bDsSzGgDyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPPwdCGj3cvdD0qZDL3OYZB16gjo07dMrLrkOs3uI6I=;
 b=gkK8DKF9UAI1sUvR3EzMLpBioqsd4il/sMLZhUHrixLuUH9LAv6LMZGo5/KE/tiYyHQ48b8i99jB1I1W6pBQyzWzpvGdMfeOVx/YRiBLhXkmGF4szfg07QawRpTa0IQ/DPlZzwbbgb1eZQv9PuJX3dSFuC3Rn7JHIdiKAgSHgiR1Oz3LpOmzB5II/MLaYIxYWhI7sDHNeKsCBysO0UO7O7Iw7X5KRc8408WhErMIGLqlFQvdAoXZqfIZnjCD+0iXyAOaPBYL8yOiMkjZr/ywh8vYv+Lipc1ITm395FQvrFY7T9L34WyE/xaBPPqxM7NxnJxUdsL3hPFNCvJs+suu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR04FT008.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::47) by
 VI1EUR04HT171.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::120)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 04:42:51 +0000
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:7e0e::4b) by VI1EUR04FT008.mail.protection.outlook.com
 (2a01:111:e400:7e0e::406) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 04:42:51 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:EE95C1EFED8D6E47100664AD3FEA6AEB41AEEC6B97FC6CFFFEE52DB7F8C0C894;UpperCasedChecksum:2C9785BF91D6D0FEF1F43F08AD19CC64592C87E1389DE52DF4771C0C3D981726;SizeAsReceived:8835;Count:48
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e5e5:7b7a:5ea5:c75a]) by AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e5e5:7b7a:5ea5:c75a%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 04:42:51 +0000
Subject: Re: [PATCHv8] exec: Fix dead-lock in de_thread with ptrace_attach
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Charles Haithcock <chaithco@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Helge Deller <deller@gmx.de>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Adrian Reber <areber@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <AM8PR10MB4708AFBD838138A84CE89EF8E4359@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <20210610143642.e4535dbdc0db0b1bd3ee5367@linux-foundation.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM8PR10MB470821E940142AD462C23FBFE4349@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Date:   Fri, 11 Jun 2021 06:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <20210610143642.e4535dbdc0db0b1bd3ee5367@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [rUDxNKlCriXynteHEiffxzIPRCDkbyeV]
X-ClientProxiedBy: PR0P264CA0238.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::34) To AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:364::23)
X-Microsoft-Original-Message-ID: <f88be100-4218-28bc-ad1a-093936fc3888@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.61.94) by PR0P264CA0238.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend Transport; Fri, 11 Jun 2021 04:42:49 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1d48908d-e4c5-4c49-5539-08d92c935eab
X-MS-TrafficTypeDiagnostic: VI1EUR04HT171:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJmsspghuqlm2mNmvT9FrrNnbbCcxRjsHPnsSU6OuxwGuAddbS2AR6moHNnrkK6k2eTgQPfFuooOkAe9m70ETWpLHcEGX6ydOP3dGLQS+sBqK8HbAODD/1LVolRy7XKL8MYR9t22r4RJN+iJkpdgvpFWilbaV1FGcl0rVkND64C5UDUbEBuxj0uQqWiJRDZ9Oi5Fz47j62SWEh7PZ1nTdfgZ46tsM4lG3TdHvGEk7k0BLj9WoLdAwvsHszZVAS9kyXE9NgK5v1jZBt67kgQWlrf1oVvogwl2Awv+4AKHExA0+m1MXWI5QtyOH8Ig8VzeqvE8irfnwawcTG93IJR5916I9Q8R5UIb+vUOzeY4W+ELes0fFIDjV1ii9omXLH3ddmP/snWNpfPiZBk03Ms1mg==
X-MS-Exchange-AntiSpam-MessageData: D7/w2tnlwlOZbNIDfTXkAIVEoofWbK038gRowI0hCMOsskuniE5GG+lppE4Zwb6PfTtvm6l6qS/udSu97fdu661/aImYHnVjBSFnW0mkg2i8ofisShhHSR5ESucmmL9+MjqD9sXhzDBYBdglelYDng==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d48908d-e4c5-4c49-5539-08d92c935eab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 04:42:51.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT008.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT171
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/21 11:36 PM, Andrew Morton wrote:
> On Thu, 10 Jun 2021 09:31:42 +0200 Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
> 
>> This introduces signal->unsafe_execve_in_progress,
>> which is used to fix the case when at least one of the
>> sibling threads is traced, and therefore the trace
>> process may dead-lock in ptrace_attach, but de_thread
>> will need to wait for the tracer to continue execution.
> 
> Deadlocks are serious.  Is this exploitable by unprivileged userspace?
> 

Yes, in theory:

You need a program doing things like the second test case in vmaccess.c
and if the parent (also unprivileged) does simply not call PTRACE_ATTACH
and not waitpid.   This is an unprivileged process.

Now if A kernel process would try the PTRACE_ATTACH from the test case
it would freeze until the parent process calls waitpid, which it would
not do in this scenario. 

>> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> 
> Was a -stable backport considered?
> 
> 

Yes, maybe after some time.


Thanks
Bernd.
