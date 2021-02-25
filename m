Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F932560E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhBYTFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 14:05:19 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:51520 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233161AbhBYTFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614279842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khND3q2P5JO6gJQuB9Q33C51QrN9ywxGjcZy7pMumik=;
        b=UeKzz1Sy6ZEAJQErc9+ubz9137D0/Z6cLSEaWrM7hsn9V7YI10Javta3UB++aaP55tj0JV
        EPK66WSO8zFmBv+HigGUJ9Uw1azTRt4AJTIn8YJt6/VFmhoeoPWJue+x6DeHM11M4MRsqP
        RrkMUR1DD9BdImgsXlH2G/jZnVuIg74=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-1-1ankPBAvNBCLdJyO8jhGgQ-1; Thu, 25 Feb 2021 20:04:01 +0100
X-MC-Unique: 1ankPBAvNBCLdJyO8jhGgQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl4Z7LrjFSSvjo912jNmB2Eh9UEw1BeKevGXOv5IyRPBhphB+pLOaEdVcQgJLxBbBgn74gmop6AQwsbPdcI88koNmJQny5rAvJh84Sy/sTRLSw8fsRRkOGQHP0E9UgkJixnYhxSX/uDXRflM/LlT5A1JYixb5VRE8QmUaRV7N0uhTA60het1a2lJhbt32q67sEMdTyaIMBen2LKoxsAKodm7AItdiMNBE1DTLVj++4/oJI2G2/5MY6WMKV6U9gSCAwOJFER4gVuZrPHVrIs7L35S+aipiP6kINp2vILdPNAjq0p15meaFNIMlouAih6MzfLjBWIkq7m0mw1TfWlwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khND3q2P5JO6gJQuB9Q33C51QrN9ywxGjcZy7pMumik=;
 b=mFoYex//683Tu/fPwXgmPbEB4vLccov9W/ql1tcIIaO20FlyYFByFdsNGU2KLE3M/tb/uidkDE28dDIBja+62ZDq19pyMzypLmVWmXt/K581OtMVJsqIiYKesYXRPIVSL3SUSIcaJfLI2EdQfkzkNaRw26Aiai6s/BdMoCSLGsxKCrqumKdg9N3o+tmS+NSJ2UvTnbUXmADj/DBMQMi+cUCQ9napqQlgtquSEnoZIsoWEEFI9LIsyXeAZr8L2XC3D4hAenBsdm335WV2q/kL25kSYS7lJcPemj8c55TkFCzAQMiVFRNsiLstBUzIHp+m+UwT9DhHxyl8st7PiWBliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB4591.eurprd04.prod.outlook.com (2603:10a6:803:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 19:03:59 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3868.032; Thu, 25 Feb 2021
 19:03:59 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     David Howells <dhowells@redhat.com>, mtk.manpages@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Add manpage for open_tree(2)
In-Reply-To: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
Date:   Thu, 25 Feb 2021 20:03:56 +0100
Message-ID: <87h7m0ynoj.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a14:ba29:b88d:f57e:aede]
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a14:ba29:b88d:f57e:aede) by ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 19:03:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de897b0b-9df5-4ad2-6424-08d8d9c01bae
X-MS-TrafficTypeDiagnostic: VI1PR04MB4591:
X-Microsoft-Antispam-PRVS: <VI1PR04MB459174FB6C45DAEA2CC1BFF8A89E9@VI1PR04MB4591.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlK391oRAcDYRKcrzf8yGRBWe4q17sOvuNMGJ9glEH4uHUgG/8r0z8WkF53EOOMDtQmagsmTKbT44fJC2s8lBZAuiS87t25/w1qdy5qI6x4OPWjTCjvu+fz7trcDEycfa6gmbV5PMGyFEu02PLXgRTMMxIawl9IU78JOBTBwXhge0Z9HXPyv8mTz85UvaneV3u93bYgnY8KUJhhcLdrupXsg0iec/SgUePRVuVrLaLu/txY2tZFMqsW6n+GkRBncg5m5OFqBrzxGtjDdjEP5EYdJxLjURMgsGPIFciU3GjQNA+3/QFmBIwnbYtgp2QMYgZblPMtJ55M2LsDXTsPx2gJYkhSzsBqFJh/0eFYVSKFVQAqmaTNg8zRqc4QzQKhhQU+0k1Jzm8GHZ+QsNTLNYcDrDQkimQv23tQ3rCQaJIPRY0DW/hA78WMF0Y7U2uHR1jZPOWEPSQ0+l1p2ibRPSIixOiZywSIxRSpG7Jrhw8AwMYwEPEUKTVJqwSBCyLegkAoNAyxXxHr0Cj2eQuYawQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(366004)(396003)(66946007)(2906002)(4744005)(66476007)(478600001)(52116002)(66556008)(6496006)(6666004)(36756003)(5660300002)(8676002)(2616005)(4326008)(16526019)(186003)(6486002)(316002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RmJWZlVqWXB3cjhEdG5ObXhwVmtrMHpmQzhkQnRvNXExbmNKRG10QVIwQ0pv?=
 =?utf-8?B?dVdxaVZZY3hMS0pBRXk4N1V6WWhKaEpPc2ZWREU5bXVzbTZmME5xbStyYita?=
 =?utf-8?B?Smlud09wdld0L0kzbG82SnZxWFh3aVBBMUowY3pkQzAyY0prUTZSU0RUWUho?=
 =?utf-8?B?MjhQL21MNWhobVNyeFlocVYyN2lBZGR5OUk2Y2VQbG85WjVRbzNEOXppSWdm?=
 =?utf-8?B?eHQ0Z2lodFVWSWhkemgweG53K2lYQW5pc2F0WVgzZWtVb3FJT0F3NEdKWC9t?=
 =?utf-8?B?UHNlanp5N0RST1YvUGNRUzQ4dnd4SlZVdS95bWpzRTYvdkJIcmM0NHQ0WVpI?=
 =?utf-8?B?RUtiKzlqSGUxTUJyV1U3Qnk1M3pmazZUTGMzWUdRVlgwRitmZjl2ZEx1aktJ?=
 =?utf-8?B?MjJwOVhlbUpSWGI2bGtDcUQ2bjdHN0dJSDBnekhoWVdnQVhlckMvVHNnTXE1?=
 =?utf-8?B?dWZLY3YxM0I0cHB3WDZHcnovakRmN2Urd0V1U3p4eFJseUtGMjJIMG8vVXVJ?=
 =?utf-8?B?YitubXhQWks4VUtrSXZHZklaQnRwSTZ0L0E5NDN5VjVwbEkxaVFpYUdJS3hJ?=
 =?utf-8?B?OVpVeEdUNXNMMXYwU0ZiZCtVVlpaMGE4SUxxbk4yOENOdHJiQzJZekMwcUQ0?=
 =?utf-8?B?QTNWSmNkN0xJSGhqTURvcXNYbDBmLytCcXNjU2x4K0dTVTBGWUZrVUNBd3J5?=
 =?utf-8?B?YVJFckI5V1dBT3FrQWdEZk56aFFTVE1Fb0ZrWXB0d3VtQ3FPQmJnYTNIaGFR?=
 =?utf-8?B?czk5MkVNbFNJUVREWmMzTHhHMVk2Wk0rTW9UVTlQSThsMmZuUUYxdEZQdjdS?=
 =?utf-8?B?ek5zRk9KaDkrZVFrTGNPcWU4Zmd0eVFzaWlpMWVvTXpHVXhFV1JVT2dhT0Ja?=
 =?utf-8?B?ZldKZEtZdGExT3czenRMOHFvbi84Q1BKZ1FVb3oxWHptcXg3SjJKRXBOK3RH?=
 =?utf-8?B?VEtXVVhyN2hxWTV0cFV1Z1lPQTVXN2YzeE80dzJmUG4xZmhTdzY2dVRvYlFs?=
 =?utf-8?B?MHQ0V2pET0YyYy8yU0w1bC9RVURQQzZPSlZNU3N2Tit1RXFnendDbW0zQjR6?=
 =?utf-8?B?U1hhcXFkVm43MWhZNE9KeTExV0lNUjNUZXAvNmM5bHByaGkvQk8zQW9VNmhn?=
 =?utf-8?B?dm56TWVWNFNiTXltbkpZQjhqc1hhZDRWUFlQMmNxdFlab3hneExYeng4K21K?=
 =?utf-8?B?QXdobXBnTVNPd0ttcm1LQTZMRnpHUURCQmlBdURSUnJqc0dyQmN1czhEaTFm?=
 =?utf-8?B?V2VaWXlBUnorejkvdjhaTHRDWGNOOG1aL01aWU1meko1QmNxLy9kUnFRMUhQ?=
 =?utf-8?B?OXZ2THFydEFqOGJ6ZlJlNlFwNUM1YUFndTl3QXJRVWN6b2FaNlk2c2V3UW85?=
 =?utf-8?B?eGxGWDlJQTRjQ1NHVW1aWkIwUTdBNDNWR05BZUExYzd6d2hTQWN5WVZKa1RQ?=
 =?utf-8?B?ajEzY2JQY2JidkRveGlhUHlnMEIwTk0vUExaQjV0dXBnNUVOZ2RYSERtdXRq?=
 =?utf-8?B?RXRkZm1tdzBUY2IwOWIzTXVMWldQdVdqL2UxeEFZM0o4Y1V3dWhHZy9UMU52?=
 =?utf-8?B?anBHY05wVUhoTEdFUVVBU28zUXRDQlJkRjlyUnFTRys4aFpOZzMwU2pEbmxT?=
 =?utf-8?B?anM3ZnpKOERxWlpweHh2d2ZMNEVqTzczL3V3anFFWnE3bE56c0FwSXFMcWln?=
 =?utf-8?B?TkYrZ0YxSVlpMFhjdmZpeklyOVhrYnFwVzdLVUFkQjRISklSNi9pelBIMlRQ?=
 =?utf-8?B?M0dieW1tTllKUzlNY0x1aHR3RUpra1NGM1lyKytJQUlmandWSlpCRXZrVzZ4?=
 =?utf-8?B?Y0Y2VjJqVVMxTHZ4ZTczR0xPSDJrWmZUQWFQTzhvMWsyZWVjNkFGT1RlNncy?=
 =?utf-8?Q?wjCSqV6DqfTBp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de897b0b-9df5-4ad2-6424-08d8d9c01bae
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 19:03:59.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxZcN63T+Cl0iZK9iAyEWtjQZzNiJ+VHOZ4KOwivgokI+dexr9pGl69khb0FYhk+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4591
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I was looking at this to possibly give it a go in mount.cifs (cifs-utils).

Sorry if this has been debated before but is there an interest in
converting those man page to RST? We already switched in cifs-utils.
Iterating on patchsets is quite daunting in roff.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

