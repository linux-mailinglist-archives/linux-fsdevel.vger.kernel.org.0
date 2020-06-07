Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349621F0A53
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgFGHKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 03:10:33 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:31244
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgFGHKc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 03:10:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvrv7u7FEvn4h95qMmhuy4+sPAlS0juXSQVmyC/mltiEQGj8hqiY+HlfraGLhs6noE88dlbVCC7xi9oALJZSqDlXO6d9gCetBe2KaE/fzF08kxC8Txb9wVh7KzSOGFdsEsZY9jKE0Dby57u/ebikwL/WLVXA4wrwBQRb3l2Iey5raA8j8oQgZQoO8V2vSM3MS7uWVX7pJtE8//Z8CMiZdBJ/uVtxEx3DzH2jKF6SxzAQLhg+ZLowNpS/FIB6xb6rS0rn0zKX9oc2NyoYNprvMRAvm2b/EemCWh3K9H+DujKIy+wW5qD0QwYytttkGGSI76SfLBWGvj0Tr+ElKS01pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIBW/a8SxWfuwJ8Ro0QGc6U9LRL50kaXru35dfnw2qM=;
 b=HWlU+ZJ1uEUfOavAPJJTUmnyUYnoNM8TwLJPf98Ol3Dl2n9rXUPkehcs/cPIyOFZg91bnIAJk2w4bdbu9/lxsRN3PBQ62GQOAWdgoC5WtMgngeDnGYLMby5oKL6pMu44q8imoE9NxplCSa/bZTpAUaZgu2MgFWJS1VYMN5dtweG7nUgcmELh1zeUkbykp3VjynTZaFbIJZDQxOHslFQV9atYjKfC3bD2kW7Hevlmx3nxxP9zhJBVXNrxr2hGWZUqbrkMzrc6Hx5Nkn4Ms8BlaVt74iLdqvT7d705MNX5YKW/0Aq+qQk4VFds9X8QzzybPVQ9MROe+MVsX+9LQ8nUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIBW/a8SxWfuwJ8Ro0QGc6U9LRL50kaXru35dfnw2qM=;
 b=kQiDot+sBszgr/4Ji25/LaT3Nph/3DHlHDOdWQb3/bySLf9Cc6lBUbtHQedJWbBxjmivfReuo035Qgl6W91HDvDqfZRZ2hjBcATRksqubbadzdR52+47A+1XRyrAhFlFtON//zv1v1g2UlKU5a03rM3I2lD9dMxvWlIvJMDsyP0=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB4132.eurprd08.prod.outlook.com (2603:10a6:208:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sun, 7 Jun
 2020 07:10:28 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2%6]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 07:10:28 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] epoll: extra check in ep_item_poll()
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <f56c28cb-565c-6cc0-8ed6-34492cacc300@virtuozzo.com>
Date:   Sun, 7 Jun 2020 10:10:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0001.eurprd03.prod.outlook.com
 (2603:10a6:205:2::14) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM4PR0302CA0001.eurprd03.prod.outlook.com (2603:10a6:205:2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sun, 7 Jun 2020 07:10:27 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c5d552-ef8a-4feb-0d35-08d80ab1db76
X-MS-TrafficTypeDiagnostic: AM0PR08MB4132:
X-Microsoft-Antispam-PRVS: <AM0PR08MB4132063609C31C2738E238CAAA840@AM0PR08MB4132.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 04270EF89C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WhO3iXcyr/QWXAsh2XTm6PEH9ll2JYTgF/AL6OVqLAaiAVA9Itq+s3c+0wWJ28rwRGt/q+7N08RgwkeDwUfOryz4mp6+xO2sxWuz+8rPnIoFrOSDvGfWdyg1ZE4vTitcLdTnGwf1mDpydhdojKL9EgqkaPzqoDOGUD2y/uwaDnyGcb9BLcHN5WJKAmFjsJv6zLepHvJ76DvSE0XbROVlhCzJ29mcVgRejR5rFNvd6RJoiS2KmKwjZFACSDGD+qxVa9feGG6X82eFeIS94Ds+Lpijdu9rPDx9Ekb6pY2q6cUWdHb/kWJZ8e8om40Rzm3EvyG5FPovUViVRjENHnmEMuwSFyrJQjo2DvRsn4rhG6xy7nnqJXW9VYpXiqrIvuT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39830400003)(66946007)(66476007)(66556008)(5660300002)(31696002)(478600001)(4326008)(6916009)(16576012)(36756003)(83380400001)(16526019)(956004)(2616005)(86362001)(316002)(2906002)(8676002)(26005)(4744005)(52116002)(6486002)(31686004)(186003)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WPfcQ4WCKMyWR2N6pOhKlNiVN6oIuiyjtkwmBO5DW5nqp1JKCo/69MXMLuD2MPjVAIm/l9pr+puIJDvGXHbTFNf05da1nuRT61v4F+R8uMWW4VYYn6YtW+nGxu+QEE/Gejxvu/DiUM1hhuqCYrQV6mERAvKtnZZR0BVnQayhFLy91TeUCRooQscChR4n9DcTicdDUygZ6e4G3HqxcXweAj25z7xDys/qAKDjUpyuRlFkhMyn2nuWnNz0oZf/T48xng6OnwGfWBa6FTIWtjBL1K/ynBF3S5g7CepL2R+J9X9DIQpNfM+WjbFiDGb1hlRlgZfKl/n9pIR8qfyTMwB/pCRdwuPJVx6a8kMRjIzE3Kvm5q4YIWd6CvLlb+AW3hsT0AyufwsYeWGtippIyiR3yXLEKYzucj5rbjow+Y2+BeRcsod9G7qfxgVg9NlhmGa3aekDs1a55AK/J3ro+4GI2aA7tbciwAIWQkqUoTh/0bY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c5d552-ef8a-4feb-0d35-08d80ab1db76
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2020 07:10:28.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBQZfUOS9j0Zpd3bg6aHxXc6YY+4iyl0ApBoMsIODk0YXp/WfJvQ984WmGBx7UEZWU8CPK33oEUkG8T8V3Bf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

reported by smatch:
fs/eventpoll.c:891 ep_item_poll() warn:
 variable dereferenced before check 'pt' (see line 885)

ep_item_poll() is newer called with empty 'pt' argument,
and it is dereferenced in the beginning of this function,
so 'pt' check in line 891 looks useless

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 12eebcd..5ddb549 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -888,7 +888,7 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 
 	ep = epi->ffd.file->private_data;
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
-	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
+	locked = (pt->_qproc == ep_ptable_queue_proc);
 
 	return ep_scan_ready_list(epi->ffd.file->private_data,
 				  ep_read_events_proc, &depth, depth,
-- 
1.8.3.1

