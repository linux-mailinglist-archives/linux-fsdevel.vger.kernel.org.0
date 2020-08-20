Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBACE24B6D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgHTKmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 06:42:53 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:49920
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730529AbgHTKmB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0bmwsyz4nfyUmQA2TfbwAfX2rik6glK//YzBFBDLARyMpcxsJ8+oUzMzmm8EsjhjajzW0wzL/JRTvoMM1HK+BCShbmQcqxvRtuHmJuwcoL7cgQ9Cvfi+jae8vwiKJVn+Fjpgkje+OxtcNBfGohOyDl/vZoJO/tNqp3aWJsR5PYXAypXxfhLRYo9g4/lXAxIVCFgyBgBLYEj6NOTTth3Su+Ub0qhBsVkMN/x4boERQdGjIfKnA2VLS3yE8KU2QENUdqI++a6OqzTYEJz5Q4CGVzJLrbB8fxGLZfg1ZOjlEfo6m6++epZsADTts7/IgxUoSuz2hqmb+yE0DirmNRbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdKiAnYJW8L8KkLp9TiPFMyxO7xhVBO6cPWzC87JmTY=;
 b=Mzm+nDmI1f49JV2byRIpJlnbo2nvVrqBblTTN2e4IzEcDY1I3poHJtEBopVxmWd6gB446JUMX5IT2OLIli4Mfjcm0RmmaIVZTgIBXnbmyDePRWmUnVDWjunRFO5Gx88N2zVg36xddxLb8ko/iiV7K2fmDbPWd6w9PhJrIpfdYYJM8YnSzsOYtLghaSE4ZywBdw8N0payuYaTkDTPcIyJ1wpioUAvGIgwW1UjLDdgtXTVvU8JZFwLlWBCcyUS1yc7X8vQsJBhzGRWd65W2LU9+xUCYOcWxTRaoFyu23+AQuEUtEOMZktZbVbwCAcqT4x+OsZ70DRrzGU1mLA4NFR7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdKiAnYJW8L8KkLp9TiPFMyxO7xhVBO6cPWzC87JmTY=;
 b=MGBJxQrwyT1oXi2U18EQaWqewwVNigFHdgWT6/YbHEYuFnwW8yyBO2Yd7F2dzYRmc3CQ1yS0YdNpInvXOVKUYdb5gVnwsvoqVk1jY/r3KwjrSSO4bvQxyG+/IHakHvG08UR6mM5vJctB1gS6oCFUlTSySgcEfPxEQbLKj/9aIA4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2894.namprd11.prod.outlook.com (2603:10b6:805:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 10:41:52 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::4497:4639:274:54d6]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::4497:4639:274:54d6%6]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 10:41:52 +0000
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200410114720.24838-1-zhe.he@windriver.com>
 <20200703081209.GN9670@localhost.localdomain>
 <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
 <20200706064557.GA26135@localhost.localdomain>
 <20200713132211.GB5564@localhost.localdomain>
 <20200722090132.GB14912@localhost.localdomain>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <2af418ff-6859-3d42-4ab3-16464e1d98bf@windriver.com>
Date:   Thu, 20 Aug 2020 18:41:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722090132.GB14912@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:a03:167::30) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY5PR17CA0053.namprd17.prod.outlook.com (2603:10b6:a03:167::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 10:41:50 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc595a2-0d88-4f34-3374-08d844f5a659
X-MS-TrafficTypeDiagnostic: SN6PR11MB2894:
X-Microsoft-Antispam-PRVS: <SN6PR11MB28947D0B017878A1CD4325988F5A0@SN6PR11MB2894.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaJt8WUemrKMQXPtQ8irYrQqqD0R713ItkbDx18v+3Yvu8rX7r4GtLuTNhLvmNTKSuOwRSiDwSqnmuf+9gRF2Ejg7XLuvoE6r/bREYvD72jDuhA3Z5ApVVNW2cnm1R7v9DPBSFui/+cCokoy9TTSf3ormritItIYi5lkZIRh6g4FoHsTPCPCicC18JedKacKwprYxNzsZ2/+a5kiSI/AWuOmdP37mgbcUlHycWVuRvvuGms0J8wz/t6wbyfhL/wRtUZCwKfu19ubPdUO7E7TJi0yst87TXBCxIyKrYC0nL6F4E5zlVyJRj5yrnac3LOrXcU1dViDFS0+CD2SM+sLE6CJhi4n/T6ywCttQXWfIzLdVDx0sXTbo5hMwBLzBXqITpGdFspHKOGTwV4yHArNha7KUq7zxJBZVnxi2Sjv13ZdaPFnX+43AFowueL2vy3HgRFmq70GdM0gFJ3LLJQCzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3360.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(366004)(346002)(376002)(66946007)(52116002)(8936002)(53546011)(478600001)(31696002)(66476007)(2616005)(6486002)(31686004)(110011004)(66556008)(36756003)(4326008)(2906002)(6916009)(5660300002)(956004)(86362001)(16576012)(4744005)(186003)(26005)(6666004)(316002)(8676002)(161623001)(147533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wHnlbSeTRsU1hZT3mxFRhO2PydN1tHemOJUH4kOgsQFGCCfTdriZORzAmssUh40NDSVaPJi2PiLJjcbpUkNXVATPBuVgbsq6rE73RQU5bqKuhCq9bImKvNVXtaAZoU9uhze8iL9wsAnk7v6F7khCNOAXPhu0UbeMZ3VnZxbyauDSUrep4Xpz4EZoVjS5P9MzmthG9Fo0zN/+6KJEYYni0frvXUWEbAB2uUJtzEg/v/KhVI8iZyNnZpb8+O9l399ExIQyfV2n2bJ82Tv5qKuC5IeaQG9DkJLd3/k3E+M6MGaKOowJZpDfa5K1qDo5iiHqvp7NeECItykgyCsLNwZtZoFHKy2ewf0sSN/vNZZFXOWNWkgo9IyLcQEQu0zexHCLcDmqBsGFlhSDvQCN6qODR+VQU6L2Xh0BNEhpopQxf2pPky+Lc4awhK8s9XATGZa+F3FCqlIPGp9+pbOkHsxS1l48M/NWnc3yWLG8w3XDpxF6y98+oRcfKaNjmzK5iRmQQJMN6j6X6FlvAY9RVCgjWDz3khd+3fdVZxSPE+dbFgCMH6xvsYqzFGkjSEx2ezvrJ9YxgDtdhMxKhIxR7mhi9bazk01TozlOuzlV42M2G4A5THbH3Yk2OzIgg4ucO8J8ypVboCHH9mecIq9eHQ5LZQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc595a2-0d88-4f34-3374-08d844f5a659
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 10:41:52.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNt6unRpiqn7CiMcB9L7GeP/NAGGJwNU0EtXWOTpn48Kf8Yer5oOFEPklthCZk9HPjoUBd0mMlCSiHlNURrXgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2894
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/22/20 5:01 PM, Juri Lelli wrote:
> On 13/07/20 15:22, Juri Lelli wrote:
>
> [...]
>
>> Gentle ping about this issue (mainly addressing relevant maintainers and
>> potential reviewers). It's easily reproducible with PREEMPT_RT.
> Ping. Any comment at all? :-)

Hi Maintainer(s),

It's been 4 months. Can this be considered this round?

Thanks,
Zhe

>
> Thanks,
>
> Juri
>

