Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3AA73FB5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjF0LvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 07:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjF0LvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:51:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3510D;
        Tue, 27 Jun 2023 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687866666; x=1719402666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EuzYjBICs3TQNIRv5arUFSyKnTRPdmjHMxnjnzVsJMw=;
  b=nxajGobffCwpGT58jYgXTzKM3drY6ZoM5YodqwdMA4fbj/SVAUr3OGFi
   nWLt2aJTFyDxs7jCZ1G2iB3FROUuJ8XQtQM0VbhGa6C2lvujC+xa6jHZu
   KtgBLY8pr683IPVUt7sfAuALEtdVCamdcMQ6AZT8+8r9g7yelVjPZoGYV
   QfZNOCvdGJMxl5VtsUhXbidoAEuKuxvzxwyTP2RrNO5CkLadRq7vOTBk0
   1pT9PHAs1gPChEvA20tjpq7lj68k3XDQvyn15Oqqrci4BKKpD58zdscx3
   OgwTmNXa1wmcr3IuGR3zRkbhobVmjYeWnvwOLQanusi++8waURGbPggmM
   A==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="236340493"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 19:51:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=macI1Lyq04kmb7Rw+LfAJHnmldGHr7wErIb4idwv76GFVV4TMBX3W8tvkQE8JDa4wtMxSzb44f49v4lWK3hc/jI1HjdN4vexplyICY6jes95rImLxowEep5Qdx43TswgaWU2rOPtbUADM5fLvHOF3SgcjNtmCbji7CXzky4PA88jKAK5gSthfnA7EUgV3veqlhahhTowcIXDv5/N6sye+txis8NBmO/3ojR4VfhWa7vd+ie4zZko8oOZqAFSHx2M5MA9DJLEZ63PkkJyUP3A+xZDHb9ko0mpp6XxKUinYusK3r2cpL+PcNbFxvMY53VQdVA0G87AK/p9ZGCFAraPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuzYjBICs3TQNIRv5arUFSyKnTRPdmjHMxnjnzVsJMw=;
 b=DUXxI3fMo2D24XwN/9LvQwL0IecRASOLitJ/QhdyQoxvx52+fet3pOABzBoTgMdEl1933pk9c38uTDozYGddzVEx0TaSZw6OGNABDDJXtiFdPCzEeF6W1cDCK9SS/zUI/w/yPLvDw2NkML6csmjLLbK2ni+sVOM9L9UqnNbNu4CpJeh/8k3hl1yOTWHULXdRuiewGG5Pc7yeVopvmZieFaLxmO0K1SkssanCErs4n5MfzJhXF9eyhlM4jjKoUDNMvwz7jewdu5bMKkmZZ3E0+LTPq3MoNab0VYJ2XIsMiDGquZZfdUlO5V3UuGzezvZSCLuBXWpt+XZfnj2rDNml6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuzYjBICs3TQNIRv5arUFSyKnTRPdmjHMxnjnzVsJMw=;
 b=X/1oLcFKFf4N1EpNhQzzoDmZ84LQeiiKNgMlqhKcEGzCrZb520aSLhZmE8YKiWHIA2fLn7lJf8M41ERU3/U269fvNtsKtmCYNWjdPsuZBzNQxDDx5cYpFiuA3x76C0DNCMnFbJGys2pEa6RajIa5sJMK9kHmqdD43Ka2ryYw8jQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH3PR04MB9055.namprd04.prod.outlook.com (2603:10b6:610:169::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 11:51:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 11:51:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: port to new mount api
Thread-Topic: [PATCH 0/2] btrfs: port to new mount api
Thread-Index: AQHZqDk7BPkI741hQkuSvuq7mg8OTq+eitUA
Date:   Tue, 27 Jun 2023 11:51:01 +0000
Message-ID: <b9028f9d-d947-3813-9677-c49bd2b72d53@wdc.com>
References: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
In-Reply-To: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH3PR04MB9055:EE_
x-ms-office365-filtering-correlation-id: 2fd99fbe-8d74-4c76-c0bd-08db7704c75b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sd9wgCEzVNHHBaRQXLTCLP7/gtWvEyw8UKXW/3sHpC9rrBBgPNyj27BGYCwG2bYLzXKBs/7saYrEvdDj7rG2le9gR6s8dHOMREZiPxSN3VB5F9E6QVw7UrPSfjHycrD+xjSCLvtEe4ZsAqY0/F6ps72p67e8+xYrJN1ND8Dqso5qmkC1tjExW9qYshHF5mhP+tEBvWsSUDAs0U88j8e5C6ztgyOHbGc8nNFTEhkR61V1rjS6v5LrhT1/QMZONsGx5JXoxiPNBVr7QWS3MW3zlUww0Ru7jiFQ3SLIW/1av/wBZ7msLH9rHAhxRRPIepIG2UnJRUmPNEoXXxO3TtRW12S8UywU5UQ9Gonspd1KoCcrT+lxV4cNB/tC/s54x/tkt07oMu19zvmQKsX0vuqeQ02a6dlyCV1aNgsf4INpv2nJ559d7sa4n/9AIWkT3FNGwa4Nfz4/dC+LYNS8LCTECELolW9gW8Xs6a4SjqH6sfM+apj2KTipslo0yafW+fhE3jMgOlWS3PbxTgCe96Q4fa4t5cTZx318EyOLgx/mAJjaOs9VH0x7paICxTCjnKshYcgtIxEYfUulu23YcwMESnPe8fspg84gZKRNq15HkYlC7LG9LRwn1y1nIPTz1Kdp2ZkR+4+ZgRD9VTWrfD0EtYT/HWqBdZYl51C8QFnqgALkEl+WrCEay0mioCwyiq88
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(31686004)(5660300002)(66946007)(66556008)(66446008)(4326008)(76116006)(66476007)(91956017)(64756008)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(110136005)(54906003)(38070700005)(86362001)(31696002)(41300700001)(6486002)(71200400001)(186003)(6506007)(6512007)(53546011)(82960400001)(38100700002)(122000001)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXluSUNHN2ZCQUdKcWxxT1NZT3FXcHlOQ0hqaUVzOERyQzJDZDBPUWsycnpr?=
 =?utf-8?B?QU15Z0JGMEdva3I3Z2VSUHdXR1c4QmRJaXBjUUdiQUhwOWtsbmxzdElKeStu?=
 =?utf-8?B?N2tPTnZzd05sRHJldkhnVTV4VjJqc2RTeHhuNmFNWHh4WDVSQjk1T3ZEdGxT?=
 =?utf-8?B?ZUxsY1RieGRhU1NsWWl2SXF5TXRaSEhNTmljTENSQjZKcWlZaFRXbG9JY0N5?=
 =?utf-8?B?YmliVFVTWXBlM3hoZ01SMTFweTZBM1I2czFjckhUZGdUL0FQVnZZaVpvZGN1?=
 =?utf-8?B?UGlYbEVjYUE5U3I3bzFKMnRXcHRyb1JBYnRYc3FOOVNKMHJqVWNMKzBDRnla?=
 =?utf-8?B?YXA4U0ZCbGJjaUlYTGNZZnhVaWNIUFVJc0VaUGQ2OGFmdkdTYW56K2dCcVNk?=
 =?utf-8?B?eWhjdFJsZkdlb3RhbGtsQWtxOVFqVFlScGpLY2pQdmtnLy9ZUVBpN3lvbUZm?=
 =?utf-8?B?NDVoTWFtWXIwdlM0ZTk5UmhSczNTZkgxeVBPVHlRTTc2N1dVSWtNZERRL2lw?=
 =?utf-8?B?b2xTZkxpRHBOSWpLcWF0eXQ0SGtUZnJXTXJXcEFXSmZsUThiNHhEV0pjTjJR?=
 =?utf-8?B?UDFDTkFDTkpHaHlLbFQvSVY4a2l6eEl6bVVWWW9LejY0K2ZGYk82cER6Tnpv?=
 =?utf-8?B?MnRoUjBhVEdGMXdCemNBMmVqKzl4OVpTNmg0eXlYRVpuaXI2MEhua2txRzNH?=
 =?utf-8?B?RFEvZFlWU3pleHdFVUk4dlF6QURaUjdVR1RHc3M0a3BqVk5qRUFnMTVFMlBs?=
 =?utf-8?B?QUVJN1JKbkV0d29RZ1VheEsrSFlGd2xXV1RnTEJVMCtZMkdLWmZ1R2IvYzkx?=
 =?utf-8?B?ZlNNNmVqZXY3TGNFWkExaDhXdEhJcC9RSlBkb1ZEdDlnZmZYRkU1SGsxdlcr?=
 =?utf-8?B?QUdXZ1BWKzdxdmY0SVM1VTZ6ODFCaU5XZmlWaVlXaktROUdvaitudGJiTnBm?=
 =?utf-8?B?Yi9FZnFSUWpJQWJnaWdyWEdQbVNKMnNJbHY0a2Jta29OcUVTUFY3K2VpK29P?=
 =?utf-8?B?b211Wlh5R0VmckhKTm9CWGhKOE9FaHlBMFZBNEd6Zk8xZnJEN3ZYUkVsd3g1?=
 =?utf-8?B?VjdwUlNuOVA5TTdyd2ZyenZLaWQrWHpaaWtqdFVHUGZQUGhtdi9BNzYrYmVU?=
 =?utf-8?B?UWdwWElJdVZnM3Z5YWxPM25JRGR1R0x5WFE2SS9sUlN5VURtYzUzcklURnZx?=
 =?utf-8?B?L2xPT0wvZXZUN0tONlREQ3FVdFJDV2VZSW5XK2hUSmRFTWZrODlDNDJYajNQ?=
 =?utf-8?B?dEUxYjZJdW83OGlMSnU1S3greVovWSs1ZDNCQ0JiMzQrcnNWcStYUUR4cU4z?=
 =?utf-8?B?OFVMQXROY3gyT2dRaTE5bDRuaGhIcFhBK3M1Z2oxUFVJVFpHVzhacmtjOFR4?=
 =?utf-8?B?bUpsZWE4ODlPT1J1eHFGVFBuODVtZXlTSGtscVZKVWxEbHI1SjVQZ0g2MnQ4?=
 =?utf-8?B?ZkRZak5DaUlqQjNHNkVMYkY3MkZCY2lsdTNYMmE2dmhzTTFYdE1NZk91RHA4?=
 =?utf-8?B?WTl6VFlkTXllVFFidytkWUhCalBJRjNyRDJsemVpTWY5b3JNaU5TVTNNR2x5?=
 =?utf-8?B?ZlpGZ3lJbVBiRTNpUlNwUWFuNXlJbC9xQnFVRjR5YkR1dXMvb1d4cEhvMzRV?=
 =?utf-8?B?OGpGYUw3ck5ubVk5SnF5TmNMS2tGakxTS0FEOEZqdU9lWWxrbWJpUTZSOXUx?=
 =?utf-8?B?TGR1akMvTm5hQnl0WFBCdll5RGdvUGt5MSsrTXg3b2pUM295NkU1M21kQzJs?=
 =?utf-8?B?UllrWkpHdWE5VEFlNzFEbHRmUVJWYjZQczZQMzkyd0szcXZkK0tsN1I5cC90?=
 =?utf-8?B?WGtQVS90RFd3TmJJeDI1VTdEaDc1bllmeEs2UXFmTTkwVTh1bWRvTGV5MXBW?=
 =?utf-8?B?SGRQaXlOSkhDRkJXaFVGZVJ4SnpCNHJGcG4rcW5Ib2pMZEMzaTVUalBzQVJX?=
 =?utf-8?B?SlRHNnpxRTBvUldHZEx0YnR1cXRTMkh2ZzdXd0FmMm5pMnpwSy9Hcmp1ZmVi?=
 =?utf-8?B?ZzI5cGFia0xkSGpXMnBESmk3SmdsdTR1OE40ZWtrTmFrNTJCV0tWdlo3cUwv?=
 =?utf-8?B?WjBiTEFHS0doUGk4a2IzMFVxc3NqZktzVGRhYUkwNk5relpwZVdBem9Qc3Bq?=
 =?utf-8?B?b0M2SytNM2lZbXkxWkttOVpNZDNwbmJUWTFkYk1tNXFveURBZStUc2JjRWtD?=
 =?utf-8?B?bzlyWWUzNWVtQlJXck04SVR0WW55U2IvVU84bE5zSTRkSWV2bDVTMCsveHFJ?=
 =?utf-8?B?NEVzbisxODVhelhLWE00bVNLY3B3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48441BDBDBA3D64BA78AEA73260C3E9C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C7VJHgKOu7T3pYOnZHI+yXWD1g8Lml4TkGAfy+tdFaQom9g5QesvsJuejg1M02UM3ZZhR6Dtn4nanFny1TQ4UJyfDCXsTPEucLF2l34Bc3ipMZuNi0ld2++28+oYvlTkcDnMQY2ogREoq8Ig5R3n5nnFyRZkQ/H0j6nVEtygBcgyD5r5IrECLC3jL78MrIjcDh+xlI3fX6HvpUqep/kX01ko5FgrNb9jCPcnN/ISJtImFnHtKsKHaJXl6qO8eslm2jgQnYNklUTGAZvtCXLTXSbJkum/zHb43ecm8JE7UHLnjmggl/MDy9UR4PNWA06vdxjWlEWghbvw34bgGaMM7Hz7C3i6dEAMIXLs3mN21oDxnG8HfcHEsAHxiM6/LtIMtqXgSFMWNhbGoCqaFoeCCxSoeBteBYBU+vbQNDyU6PQPghNUvKhgbnbQ5fSODueePz6Q+Estu40A7Zl9jfQAm/4msxNe+ithfC+tVW9eTvu6qUAbaShHsruyk3/7TeVWpWQYjlr+0z2LqbEG9FLR75fl4jUfJols7clTr0cvbIEo5nv4yYb68y0sjX8LmQeK+Y8VBeBNbkIjEbY+EG6dpQv9pt1HEt8ICoqn9Osh5D57AWtZH+NlPeKo+L8+QSmS9GnjDfq0su8JK9xSmciXU9uaKsqVlse7p1KrKXqGvSto7nqnXg/uDOS5tWCXqoAyT1gP+rjh530mzMI2cMs4+Z2X1OGRovjmWQX2EF4FkkM90LLujK5LGwsq+D1qfFyy66TTklw1fDaU2PkG9zbh5ZzSrzImJG+yCmjh83qT3Izh8i/CGpv5MNF5UaJzo4o+dl4hatvmI3h5OdzjmR88MoSS3xj9Govu0/x18pSQi8qrSihQLs8fQAGXmhzMsONLKCvzMUCyHe/G9ImWIojyqg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd99fbe-8d74-4c76-c0bd-08db7704c75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 11:51:01.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3x+7KhSPX0r/v+e/EufJSx2jj2eAKvBeygAnl4Fr5+WsnUfAVC7Ys06il8W/YbPNqOnRMIpiUbGJcohFicVdRbFW+SFmEC6jvJ8UFrHlnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB9055
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjYuMDYuMjMgMTY6MTksIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBUaGlzIHdob2xl
IHRoaW5nIGVuZHMgdXAgYmVpbmcgY2xvc2UgdG8gYSByZXdyaXRlIGluIHNvbWUgcGxhY2VzLiBJ
DQo+IGhhdmVuJ3QgZm91bmQgYSByZWFsbHkgZWxlZ2FudCB3YXkgdG8gc3BsaXQgdGhpcyBpbnRv
IHNtYWxsZXIgY2h1bmtzLg0KDQpZb3UnbGwgcHJvYmFibHkgaGF0ZSBtZSBmb3IgdGhpcywgYnV0
IHlvdSBjb3VsZCBzcGxpdCBpdCB1cCBhIGJpdCBieSANCmZpcnN0IGRvaW5nIHRoZSBtb3ZlIG9m
IHRoZSBvbGQgbW91bnQgY29kZSBpbnRvIHBhcmFtcy5jIGFuZCB0aGVuIGRvIHRoZQ0KcmV3cml0
ZSBmb3IgdGhlIG5ldyBtb3VudCBBUEkuDQoNClRoYXQnbGwgYXQgbGVhc3QgbWFrZSBpdCBhIGJp
dCBtb3JlIHJlYWRhYmxlIElNSE8uDQo=
