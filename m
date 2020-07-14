Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422A321FA88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgGNSx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 14:53:26 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com ([40.107.7.139]:62116
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730595AbgGNSxY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiTjs03UC+LRgS7mRQavCr7POC4BVIg80vh63L5h8YPBdxd8Vvoo0BoC6hjejInJhYcCcYyM0LkJ/OvHVgxPb0FkbZ0NR+PA8nAP4Gm0zm1LW9ip8HJVWMDzuqcuy0H8vBnC5U2ANHknoD/i+RfzOL83oOaruWgwagYlOJ1F0nEIacZl4OwwclTFdG0RiGmJxV6PQTSnLR12oGiQajccILj/zQqOGoOKj+pFyQcTXiGJVcBiRnBbB+2zkySaLEBOLXcc5gJ9t8vk7Fmxnu9lqAgrlYjAinxYX9Rlo8Ly6DiafkPoLCWHF2dVRpz0TRJ+kSkil/D8iuU7yH/v7BvzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkJk/QW4+6sz5VjkQqzDEm7rRYHji4MDw/xtmmnApXg=;
 b=Ii1PbOyxndb0p3UUXau3OtQlGtbmQOo6Jhic7lQgNT4UDx67nfJseFqlW8/7JBfv2CHWtZhQAneCsRUK2xL6/ZSNJDsGo+m7ifGLsQczPpbWfN5j0Ogth0XNyxDZaZ94/aA4IMbMHu4FQUpHGjIyP9kLU8HEntl4Jv1DJ+aP2Mqzcr4mEhclrUJKgE3Ua9PCpcaE/JKolQgVh/0fU6f9Eo2FxG6C/gyzCpWQz6gcvVSUhUjIg/Fwyhqiw+nDQZ+2UsA1QfCeVS+wErkMxEu8ndTLECp6xMofOHr6Ca5Ododunw7cdp2HKNZCNkXXk07niNbz7mEDRfSsp8XtQ1eNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkJk/QW4+6sz5VjkQqzDEm7rRYHji4MDw/xtmmnApXg=;
 b=Fjxkh1lcSDZ264LYWFoij2TCUHOt/TlmmzgINXs9GjiEiS9xNc8CJpzvJOJ1HQz5wJ4cJr6ZwCPlOuHFbqcN5PiSBVAV4HMCTqrH5ajOenEMEs6p8opA9ID6evc98Y443RCf8zuviuEZcN/YGoLzAZ+hw8noJwK7g3wD48MLJUI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB5141.eurprd08.prod.outlook.com (2603:10a6:20b:e6::26)
 by AM5PR0801MB1940.eurprd08.prod.outlook.com (2603:10a6:203:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 18:53:21 +0000
Received: from AM6PR08MB5141.eurprd08.prod.outlook.com
 ([fe80::9c6e:e0d8:57b1:4cfd]) by AM6PR08MB5141.eurprd08.prod.outlook.com
 ([fe80::9c6e:e0d8:57b1:4cfd%7]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 18:53:20 +0000
Subject: Re: [PATCH] fuse_writepages_fill: simplified "if-else if" constuction
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <446f0df5-798d-ab3a-e773-39d9f202c092@virtuozzo.com>
 <CAJfpegv_7nvWoigY-eCX0ny+phWYOz3kEZvYsuGb=u65yMLGHg@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <0bf36680-d659-9466-9634-92328d1be082@virtuozzo.com>
Date:   Tue, 14 Jul 2020 21:53:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAJfpegv_7nvWoigY-eCX0ny+phWYOz3kEZvYsuGb=u65yMLGHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0123.eurprd04.prod.outlook.com
 (2603:10a6:208:55::28) To AM6PR08MB5141.eurprd08.prod.outlook.com
 (2603:10a6:20b:e6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR04CA0123.eurprd04.prod.outlook.com (2603:10a6:208:55::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 18:53:20 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe27f93-bfc3-4d12-d248-08d828272d90
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1940:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1940139347BB896890AFB09EAA610@AM5PR0801MB1940.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaPnh4j1U4UVsnSe50t0WXlujH2nkePa6HjEaGr7qBGQLDwWsaJkD8jDidUaIlRR3IPyBXgoq80rie+bmsfN1POAQ0ENfk1RDMxh3f19m8QGH0TxT9LN9ibu7AMC52rLSdmFS0o/vNWQSqrhJitSKnTLa6QF3XKg7JfXTq9JI3GzcBfVHHXlmbtz7Tq/ubaZiarj8AhVwDX8ekBq7zIAJSAmq1cKDDVRHnU/2agkCLqXzIAic05nTq8ucQVyi5llNNleCbr1VUi6O1zeERw92r/M1cq6Mkr54ryI6Vw9/eWncMsk8E036IwOkykAVunogxf6xqd0OD3UgdPu9mEHhENJjXbUKeCDO+pebHwiM9OSP23cW/S/tZ+fYwUXDcXB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB5141.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39830400003)(366004)(376002)(346002)(136003)(86362001)(54906003)(8676002)(31696002)(16576012)(66476007)(2906002)(4326008)(52116002)(53546011)(316002)(6486002)(66946007)(66556008)(6916009)(186003)(16526019)(4744005)(26005)(2616005)(956004)(36756003)(478600001)(8936002)(5660300002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oO1s0hfhkfSuk8335UoSQ3XHWSDk/kYs1CoBMztPz6/mJ/6A2S/1prLLjWQuKWF8SqZynKBSU5ywZEII0krYped77s216t/V3PvMfx9VsFE7hruHwZvkWAW/pFKci9QvCOU5W2976kShbdKQvhrK8zIcDVnjJD4V//jtmFagVJhB4gcA6WpLJA/BEZAYaNfMxhguQ0jpP7lieuc3dKVBUirmRvU+sYcngZmNlUbRqQybrKReJYSth7FVXQUUe2qsSSHG6/48zqNQWIpqcuXUNLyAGaMBdLBI/Le3HN0Rdk5UKj54HNaksu8+5WYkhl90UkodeJberDVY+TcY6kbqcYFN1tCcLPp7TgiKJATD5BPK6xSk/VhJwP73blbekZImFTAlNc/JDU3RzVqDDmKdf3EMfGZo5K06EZzEUa8FheMXpCdYS5Rrwws4qunCuTu6qqKSzQRWgKHw9/W9HD+F1hw81FiZ20Stvv4OOG9gZZ4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe27f93-bfc3-4d12-d248-08d828272d90
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB5141.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 18:53:20.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fE70o2WfdHHw0Jbm1PuiKijXYcgmndNcDkG1I8u2/gAMCEJjgUvD4SY2W3w8KIk7IJnNrOke3q3JMhbmWPSBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1940
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/14/20 3:24 PM, Miklos Szeredi wrote:
> On Thu, Jun 25, 2020 at 11:30 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> fuse_writepages_fill uses following construction:
>> if (wpa && ap->num_pages &&
>>     (A || B || C)) {
>>         action;
>> } else if (wpa && D) {
>>         if (E) {
>>                 the same action;
>>         }
>> }
>>
>> - ap->num_pages check is always true and can be removed
>> - "if" and "else if" calls the same action and can be merged.
> 
> Makes sense.  Attached patch goes further and moves checking the
> conditions to a separate helper for clarity.

This looks perfect for me, thank you
	Vasily Averin


