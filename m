Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA9209C0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 11:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390964AbgFYJj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 05:39:58 -0400
Received: from mail-eopbgr60112.outbound.protection.outlook.com ([40.107.6.112]:52231
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390350AbgFYJj4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:39:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCroTc/ykNl422YUO+DIIeyHr8DF3+jyxQckAx2F/E0ZU5Kdw2AkEmHzFTYeZAiyQqeYpO/nLoiHT4QcFgo0wiTz4N+ZI0DEK10gZUlPGZgPNNkc2vVq8ZtDU1h9u4yv0HkghZcj1JXFsYIEe0QqF44SrPAZ0TRdB1y0pNa+SHAjBZVxiLgqto5ZVrpCyNLHhsl50bFSqux/AnJXTABLHpotAo4MKmXECq85AvkfwRf4+cOSxuprSy5P7ox495Bgf+Vi7a0PsmlcQ2HNsDSY5ylmRMz+f8GYDzR7oRxocpSg322Bcw4ZCUP+aSJOZn4Cultx1hueaphNQw91o0J6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS2iMm4pOlEAYANxVaoGjoerWbcd5XN6k7ye3li7wn0=;
 b=IoB8nTNxJIMbFNF8AASIrh0VWkG9FwddKZWmjA0lZnje5gOaLjo3lWcw3jy9JXpG79BJ6n7rucmyvK9ZfzfFtFVoUQdDg++BfZGIOG1yOmfGWbAcGRBStKWzB/676QufBHpf7DYVbmbzBtgkCM/lAiRPTvFCHFBbjSf+eS9sCmalE4F1kzL6h+docBPV0gBL9A1x8e7MPw+pkGuCDy2mZMaBx3L0mhsMmhvgCN8QCoLX5nSIvpQnjTHtEhgk+jBAc6E5tUavJ4KipvOeCmGpKa43XShTnfXofgrGpvMjuYtjSHq1inTMjysUYD+G7PMQYzkM1DejGInWoHgXc6xwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS2iMm4pOlEAYANxVaoGjoerWbcd5XN6k7ye3li7wn0=;
 b=gbf4IIoVZ8OhX/dYgHv0gBjxiSbSXYGw5iJ7VCRIZlnNbNaqglVAuTnWnCcxGDbINaPyMPo58Lyoxzkjc8/9bo0eXthxsIMbxMvaEmdwBAKjIpKpVG2yGPRqAh7e+kF+nTDi4xdt3tbci5MElpxb2m7BGZwPNhMOyic/kKfDuYE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB5425.eurprd08.prod.outlook.com (2603:10a6:208:17d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 09:39:53 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3131.023; Thu, 25 Jun 2020
 09:39:53 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse_writepages ignores errors from fuse_writepages_fill
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
Message-ID: <be5341bf-6631-d039-7377-2c0c77fd8be3@virtuozzo.com>
Date:   Thu, 25 Jun 2020 12:39:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::44) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR01CA0175.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 09:39:52 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad7cce6a-b9c7-4038-7a0c-08d818ebb67f
X-MS-TrafficTypeDiagnostic: AM0PR08MB5425:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB54258D960ECAA461A1C27A1AAA920@AM0PR08MB5425.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67UagCNdAqAoREhmtWgE54rJVuDQtRwu2Cl2zCjUzYMFPNCT9zXyLF5oakM78LdzCrh3NarJssZHf3rfCHx56WQCf2AxCffq86VGGCSbsvSDdAKm/yzJU/nGeNQVhwy/Anc24LeM9V3KBB6JM9QUQuzSf/jDHgBnz2RAhpTzbUw/SaDeB+02VvUv7XXWzk1mBSUsyj/dogLOS9qynfsI/b/ZBRCVrpiShFoDxOTGAUdiQtRbcHmqCnd1QlTYPE+xCOdrhmLkgkDZmONlBMch/HD6KckHshxhePyNvof1jr9OYqPkaoN+rr5nkN5+Z5oRz2zQnmbuOq6vwhhKFgyLQjtdHEwx9+sAa0DshjU5ENuZH1YS8fehrZa93x69xjOn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39840400004)(366004)(346002)(376002)(136003)(316002)(83380400001)(66556008)(54906003)(16576012)(66946007)(66476007)(6916009)(52116002)(16526019)(31686004)(186003)(6486002)(956004)(2616005)(36756003)(4744005)(86362001)(8676002)(2906002)(4326008)(26005)(5660300002)(31696002)(478600001)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TM/ZDYcDwh2qJKEJOCo5D3gZJDIwnsnz52efl0cEMurV6GkYigxA6mBgdEHdemgX8tUJ4Wn4NQ45FLX/kE3ETyYxaVZAqakX9b7qbZ9nKU928Ypxqf6fb/Eld1oLs9rLAuX3HFNCoMm/KEywD5xh+a05LCyDPX7UuK543GVryPyI1iT0zZJjI6hGHr1+GAoElTUO6LcZKsQSdPGOmI25oqobeiBiPsv1WeTg9qMiZNpKpM5yhfY9twqAxdNVRYMcKRNCeLRefa4DI0Dx16CnU1uIRgyrVQsQdprMYXZj1H1h4cMNObWTyewH05wMlxkJGXqrZ0cLGKnTXSfYBC75iwqyjxK+aG7NFeSZv5ipeqYxCIEum3jlE5JPPhQ2LwvpvSmy8cd9Kop51pktD1LSHienx9Zrkw2XMMzG7gfGV7TudVfrQztwYaKvLYikWVXfiZgM8qvZIwbSySTYmF1Yn2Q9xwzvOD75XjmNgiK96bU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7cce6a-b9c7-4038-7a0c-08d818ebb67f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5140.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 09:39:53.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbGQts5tno2GIibTCw1T35wjMZi0yGzoA0UvO+WS3o5SsA4HUrkDW9jfK0jMLf59KO4JPvs29WJMp89FtnAMUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5425
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fuse_writepages() ignores some errors taken from fuse_writepages_fill()
I believe it is a bug: if .writepages is called with WB_SYNC_ALL
it should either guarantee that all data was successfully saved
or return error.

Fixes: 26d614df1da9 ("fuse: Implement writepages callback")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c023f7f0..5986739 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2148,10 +2148,8 @@ static int fuse_writepages(struct address_space *mapping,
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
-		/* Ignore errors if we can write at least one page */
 		WARN_ON(!data.wpa->ia.ap.num_pages);
 		fuse_writepages_send(&data);
-		err = 0;
 	}
 	if (data.ff)
 		fuse_file_put(data.ff, false, false);
-- 
1.8.3.1

