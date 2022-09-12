Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345615B5CD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 16:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiILO4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiILO4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:56:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2116.outbound.protection.outlook.com [40.107.93.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413515FFA;
        Mon, 12 Sep 2022 07:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE2HV4h0HVCOXAVP+SXAajUUfLW7ylbt2FSzvNNtJW79KZfXafH/81C+FTpKJJPoZhbC4gEKxEeukxBeMFZciD5u75GLeILw5Ra/IVv53aAcvK0Kty7n8CUUgAEK0ShUuiJHf2QfsJQolLWDR3RODGhN5XSLUMWZWbIGJ3DGl3tbmJ/73zr8yxGrvUsg6pPuoAlBBCTJvr+mHbta/yH9hq9qlc0K9sNpj796lSdSOuKZCgplyli4rmguQ1hlIzm1z7JzXwF1OdLahPJD+lqIAKKitwDe77OCa2WO/TQou2SwpsWykS2tksYejNRKMidE/D05d4LE9eCmn2+Uw9QNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqUrcYO5vnyrnWAV9ZfWzMyVoL6/+A3FilHCz9naCRY=;
 b=O7iZG3B9HKzhVoc+/r+fchtxQZMxIg9OV1WFXY9GPJiz2ibYPhMnX3PmRFz2OZlJUgrWEwrZO+dVk9j77ngH4CcOYL04nbSmoWZL2+SkrXx1aXolBIWypjTwjuEpwIYIn66mjYm4JGOOZGAmF51vEF0Udtz5m2RvqgDoGTyw9aLsFaD8LQDJ89RCXIpOrrvDDmogrjNxYgfbwv15pURkjtJGkAPXlhbHli6lnrSwY/3ScTuUE9eXDbCj0zfPibWflPxHy6ZCAhO9hqS8np+TfWqRHQp6/UBQyrq4WoVfFOA6g08MkrmDM06S2qjL8VxQ6W11DIBTbD5ZlGZ2WMR56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqUrcYO5vnyrnWAV9ZfWzMyVoL6/+A3FilHCz9naCRY=;
 b=dUdiVGECLz6gg/LMCQ7HeEcD4JilZ8gE2ZVCwvOfIHurteeM14z2u6JjlKzNcjSD46oBnkpc8FLpAnURI1GsXAwQbGfYkK+bg3cOaWqFe58iurMmH6QNLgBAU78otsOreXn2AsXjIv/hIiapVm+wIg01PiunFl+c7WkIn0yvbXE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL0PR13MB4435.namprd13.prod.outlook.com (2603:10b6:208:1ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12; Mon, 12 Sep
 2022 14:56:33 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5632.012; Mon, 12 Sep 2022
 14:56:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAAzmAgAAdFoCAAAvtAIAADJkAgAFZpwCAAA5bgIABdkIAgALuiQCAAAizZIAAC6QAgAAPxoCAAAadAIAACf6AgAABjQA=
Date:   Mon, 12 Sep 2022 14:56:33 +0000
Message-ID: <626f7e46aa25d967b3b92be61cf7059067d1a9c3.camel@hammerspace.com>
References: <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <20220909154506.GB5674@fieldses.org>
         <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
         <20220910145600.GA347@fieldses.org>
         <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
         <87a67423la.fsf@oldenburg.str.redhat.com>
         <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
         <20220912135131.GC9304@fieldses.org>
         <aeb314e7104647ccfd83a82bd3092005c337d953.camel@hammerspace.com>
         <20220912145057.GE9304@fieldses.org>
In-Reply-To: <20220912145057.GE9304@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BL0PR13MB4435:EE_
x-ms-office365-filtering-correlation-id: 553cebc9-526d-4506-3575-08da94cefb9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86cAOaq3Kq1xkTdsylpLeuL8EFSOD41e6TtqBcD5o9Ftew2jokXajWZHUa04GL3nnaN7Gtv4jIuOClOQT7ujvirmAoQxay8NDIeScXu0liAw+XEaUsm4WucBirbv1R/ThclRVIgrEG7/NsQyXSFSnLh3VH9ocvllzTgrpgrbJ+I8xWg+OnzfaasAgca6DN8/8Z+xNNhWPzGTWU7OU38RObFXowT13b8pMnMptZZX1hauihFDYw7cdF0rgyWmKpD7qcFG7iPNx+nchv6Yga9teCGEVHlxEevsXp3RNBTgfYfbp2hlqV3efeRMgqkN0v4puau8U3XQf14IbRXrN7hVc3L2iH0f4jbavB72V0Hrs8vxviiejse/kHFImyCgwREDyGknN0eX+xZHlxxDF3doSLSMo2UOUGL0G8DQNWcBcabQpdrcKREw9fInLKbEAUIewMspQpcDQj8q3gZytB0Pypeod8oukGWHSVLJGVV3JqJ1rzIJRCg1YNfwqvPIFLvs6KQ7JbsVftO7ud19Xtx1In5LXYjsJCcrPv4uYudPxPtZCZzB9w3LUjXwyNZpPICQKlwGlr+wcBym+RYyrmffwsxviPueYaZBQ1wId8LfTzRVXzMt4wxV6CTIR+xCJeEOSKAZ4XRB3vhmImrnDv+pvtY851eh2KrZpLXYBAYOnvLvszIP7O4uzSmXFmFH9oMZ8Iz7eAyC9ACaQ4WrMflAPKLgFBH9PoIAEzDAF5kOMStmzFko919STslv8ymLjD+NpQjn4l1YRIFgOuIrvQR7uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(346002)(396003)(376002)(136003)(366004)(83380400001)(6916009)(54906003)(316002)(6486002)(478600001)(36756003)(2906002)(26005)(6506007)(6512007)(186003)(2616005)(38070700005)(86362001)(38100700002)(122000001)(5660300002)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(8936002)(71200400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG1hSnVvcGhqRE5qQXVEZTAwVHBHV3Q3K2kvVzkxdHM0N0s1UnN6eHpQeUlO?=
 =?utf-8?B?V2dGb0kvYTlKcitIUFU0ajBrNUZTNjd4dllPdkhoR3ZFbWNOUmlpUCtGYktU?=
 =?utf-8?B?dVM4YXVHcWdDRkpNc2lIWlNpVUNtMUNLTEwydFk5bkdDbGFHSUc1Lzh4RjNr?=
 =?utf-8?B?V1BmM2x5L05UV1V2UFV6YXgvSHk0NGFYTEk5VzZLdFZHM3luWi82SHM5MndY?=
 =?utf-8?B?c2xUUlpiNmFuajh6NVNRbXRNbDVMQVpxSXdSbWlRemFreUUzaHlNQzJDY3BP?=
 =?utf-8?B?TzlyZ3o0dzBySjE4cWhaNnlKQ3grUVl1MVNybHlWSzFJQi90d2FCNnd4WWNx?=
 =?utf-8?B?cHpqTGN5cTg2cHZvTUFQTVU3S0NRa1YxdGN3TXlkaDJFZEs5WHZYRmZrOFl0?=
 =?utf-8?B?NjRSbndaanhyYVdPQUduREhPK09wRkpTM3RubitxZC9XMHh0V2NSODBXa2xE?=
 =?utf-8?B?UDRySThRVTNSTWsvcXdxUjZGbkdEMVpnVnVQcC9ZSUxzTW5RS0toeGpma0Rr?=
 =?utf-8?B?OC9iNnE3eUVZb3c2ZFREVTF4aWFSUUV1Q2wzRW9mRzJRR0tIT3VXYXVlNWQ1?=
 =?utf-8?B?ZU43aitCeS93VXgyVm9xNFEzV1NJa2ZsaGl0UmVTM3ZjMmdRZy9GVnV5M21V?=
 =?utf-8?B?ZC9qejJGVlpPQWFxUjBWakVESDVwZGJ5UTdSOHNsU0JsbmNKVzZydmYrYVVN?=
 =?utf-8?B?cXhMN2Y2UXFkbVB6cW1ySzdzM2lVcnlwODhtZk9PdmJIQnNiRlVZWXJpZ2hy?=
 =?utf-8?B?aEg1ZktUb1hEZlhEVWQ3cDhNcjk1MktRUFpkRWFvOEJwTmVvTUNxbG8wZElL?=
 =?utf-8?B?MjFxNGxKU1F6cE8zMlVKMzEvY3dLN1QzRjVLOXVGTVNyOW9GTVR5RXFDZzVM?=
 =?utf-8?B?MVVyelFsaDRhbUNsbjk0Y2FSdlREdHpHbTVzeGdBY3NLZUt4UFdBbG5idG5p?=
 =?utf-8?B?UGRkTFIxQW41S2FCZHhuMUFqRVhYZHplY2I4c2NrelBoWHpwQkZqcStzUDFT?=
 =?utf-8?B?VjBFVkwvTStTVmxlTEVNeHRNSko0ZHFUMUdqb3VVMXBuTE14S3A3R0NPaVNU?=
 =?utf-8?B?clhMbkxSQlhaazdFQzVLL25kS2tuN2ZlZUV3VnBwTnByK3ZldHZXTkI5OXlX?=
 =?utf-8?B?Wk10RE5NTDFJaThlVEpad0d1a0Q0cENabWpJY0NMRWpia1hybFRIemFzdVp3?=
 =?utf-8?B?YlF2UlVGVWxkOGM1ajRJQmR5d3MwVlRmdUhIS3ppRmJHRTdudnNiTHBaWWl2?=
 =?utf-8?B?SzZVcUh6ZHZuVG9vY0p4M242WjJPZlE3Wm1qNU9WR0Zya2ViOVIvUXM0aHRa?=
 =?utf-8?B?OW1ycFNreVFaSmlIdG9TR1FaQ1cyb1hpdm1kMjA1a2NpUy94aUhHeHhlcnAx?=
 =?utf-8?B?cE5oZEZRZ1BITVExWk8xQmpHZW00RnU1M2FzMFo0Y2xRZFNXUmdNWnJvQkFS?=
 =?utf-8?B?MVcyaXI3UzNiOHhIaWduazJFNkQrL3RURzRjeUZTUWN2c3V3cWd3UG93Qkl2?=
 =?utf-8?B?VkxXU1pXR1RQbXVkeTVGOW1VNk1aR1U0aHJmUksxZ2xNOFJZWlR3WDIrQXVH?=
 =?utf-8?B?aStDaCtNZTdzeWxqNkVUTCtSZDNCK09Ic3RLVmJPVmpxZGlwUTd2eUE1UytP?=
 =?utf-8?B?L2tjQkJ5ekNUMXg4aDV0dTRQdHpOeDFjd3NZNGZRbzM3clRNcDJJQmN5ZUxI?=
 =?utf-8?B?cUFZc2plNFlJaldJTGpxbDlCdFFKdWxRMFFjV2VmaXhMbHJVTmxqQ0dkTFhD?=
 =?utf-8?B?eUQ2cnZrcXYySzVPZm00U002QXMrSUlUY1l2QTI5eXhJUGFLQ205R3ROc2k3?=
 =?utf-8?B?ZWRJZ0V1MkhGUzkyUzhNNU9HYVlmdUJMQ2Y3Ri9XSWRNYTl5TkMrK1VTREMr?=
 =?utf-8?B?WUpHREcxVERLRno3VWh0WTg4K3RsZjJKZWg1bG1sUE4veE5reE5hYVNOZ1d5?=
 =?utf-8?B?bXdjbGgydFh0S2pDa0tzK241MHlLUHlLMnJGckdjMWl2c0pudTVEZlBDQ2Zy?=
 =?utf-8?B?UG13cTZaQU1zaWtWYy9Yc0RPOFdzajQ4Y0p6WjQ2R2E1czc0b3Bwa1FQWTNO?=
 =?utf-8?B?S080QW5jUHdMOXhOUlIrV3RWTndxc3cyQ1hhWk0xbUpyVDIrNEVLWXRwMTNJ?=
 =?utf-8?B?c05oeW14MUZVTW9QQzhwcW1aV0NBWnVGc1Mrb3pHby9BMnNSdFFqTWsycENL?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <933FD62581CB0B4FB4740A23E6E132AD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTEyIGF0IDEwOjUwIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIE1vbiwgU2VwIDEyLCAyMDIyIGF0IDAyOjE1OjE2UE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjItMDktMTIgYXQgMDk6NTEgLTA0MDAsIEouIEJy
dWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+IE9uIE1vbiwgU2VwIDEyLCAyMDIyIGF0IDA4OjU1OjA0
QU0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gPiBCZWNhdXNlIG9mIHRoZSAic2Vl
biIgZmxhZywgd2UgaGF2ZSBhIDYzIGJpdCBjb3VudGVyIHRvIHBsYXkNCj4gPiA+ID4gd2l0aC4N
Cj4gPiA+ID4gQ291bGQNCj4gPiA+ID4gd2UgdXNlIGEgc2ltaWxhciBzY2hlbWUgdG8gdGhlIG9u
ZSB3ZSB1c2UgdG8gaGFuZGxlIHdoZW4NCj4gPiA+ID4gImppZmZpZXMiDQo+ID4gPiA+IHdyYXBz
P8KgQXNzdW1lIHRoYXQgd2UnZCBuZXZlciBjb21wYXJlIHR3byB2YWx1ZXMgdGhhdCB3ZXJlIG1v
cmUNCj4gPiA+ID4gdGhhbg0KPiA+ID4gPiAyXjYyIGFwYXJ0PyBXZSBjb3VsZCBhZGQgaV92ZXJz
aW9uX2JlZm9yZS9pX3ZlcnNpb25fYWZ0ZXINCj4gPiA+ID4gbWFjcm9zIHRvDQo+ID4gPiA+IG1h
a2UNCj4gPiA+ID4gaXQgc2ltcGxlIHRvIGhhbmRsZSB0aGlzLg0KPiA+ID4gDQo+ID4gPiBBcyBm
YXIgYXMgSSByZWNhbGwgdGhlIHByb3RvY29sIGp1c3QgYXNzdW1lcyBpdCBjYW4gbmV2ZXIgd3Jh
cC7CoA0KPiA+ID4gSQ0KPiA+ID4gZ3Vlc3MNCj4gPiA+IHlvdSBjb3VsZCBhZGQgYSBuZXcgY2hh
bmdlX2F0dHJfdHlwZSB0aGF0IHdvcmtzIHRoZSB3YXkgeW91DQo+ID4gPiBkZXNjcmliZS4NCj4g
PiA+IEJ1dCB3aXRob3V0IHNvbWUgbmV3IHByb3RvY29sIGNsaWVudHMgYXJlbid0IGdvaW5nIHRv
IGtub3cgd2hhdA0KPiA+ID4gdG8gZG8NCj4gPiA+IHdpdGggYSBjaGFuZ2UgYXR0cmlidXRlIHRo
YXQgd3JhcHMuDQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgdGhpcyBqdXN0IG5lZWRzIHRvIGJlIGRl
c2lnbmVkIHNvIHRoYXQgd3JhcHBpbmcgaXMNCj4gPiA+IGltcG9zc2libGUNCj4gPiA+IGluDQo+
ID4gPiBhbnkgcmVhbGlzdGljIHNjZW5hcmlvLsKgIEkgZmVlbCBsaWtlIHRoYXQncyBkb2FibGU/
DQo+ID4gPiANCj4gPiA+IElmIHdlIGZlZWwgd2UgaGF2ZSB0byBjYXRjaCB0aGF0IGNhc2UsIHRo
ZSBvbmx5IDEwMCUgY29ycmVjdA0KPiA+ID4gYmVoYXZpb3INCj4gPiA+IHdvdWxkIHByb2JhYmx5
IGJlIHRvIG1ha2UgdGhlIGZpbGVzeXN0ZW0gcmVhZG9ubHkuDQo+ID4gPiANCj4gPiANCj4gPiBX
aGljaCBwcm90b2NvbD8gSWYgeW91J3JlIHRhbGtpbmcgYWJvdXQgYmFzaWMgTkZTdjQsIGl0IGRv
ZXNuJ3QNCj4gPiBhc3N1bWUNCj4gPiBhbnl0aGluZyBhYm91dCB0aGUgY2hhbmdlIGF0dHJpYnV0
ZSBhbmQgd3JhcHBpbmcuDQo+ID4gDQo+ID4gVGhlIE5GU3Y0LjIgcHJvdG9jb2wgZGlkIGludHJv
ZHVjZSB0aGUgb3B0aW9uYWwgYXR0cmlidXRlDQo+ID4gJ2NoYW5nZV9hdHRyX3R5cGUnIHRoYXQg
dHJpZXMgdG8gZGVzY3JpYmUgdGhlIGNoYW5nZSBhdHRyaWJ1dGUNCj4gPiBiZWhhdmlvdXIgdG8g
dGhlIGNsaWVudC4gSXQgdGVsbHMgeW91IGlmIHRoZSBiZWhhdmlvdXIgaXMNCj4gPiBtb25vdG9u
aWNhbGx5DQo+ID4gaW5jcmVhc2luZywgYnV0IGRvZXNuJ3Qgc2F5IGFueXRoaW5nIGFib3V0IHRo
ZSBiZWhhdmlvdXIgd2hlbiB0aGUNCj4gPiBhdHRyaWJ1dGUgdmFsdWUgb3ZlcmZsb3dzLg0KPiA+
IA0KPiA+IFRoYXQgc2FpZCwgdGhlIExpbnV4IE5GU3Y0LjIgY2xpZW50LCB3aGljaCB1c2VzIHRo
YXQNCj4gPiBjaGFuZ2VfYXR0cl90eXBlDQo+ID4gYXR0cmlidXRlIGRvZXMgZGVhbCB3aXRoIG92
ZXJmbG93IGJ5IGFzc3VtaW5nIHN0YW5kYXJkIHVpbnQ2NF90DQo+ID4gd3JhcA0KPiA+IGFyb3Vu
ZCBydWxlcy4gaS5lLiBpdCBhc3N1bWVzIGJpdCB2YWx1ZXMgPiA2MyBhcmUgdHJ1bmNhdGVkLA0K
PiA+IG1lYW5pbmcNCj4gPiB0aGF0IHRoZSB2YWx1ZSBvYnRhaW5lZCBieSBpbmNyZW1lbnRpbmcg
KDJeNjQtMSkgaXMgMC4NCj4gDQo+IFllYWgsIGl0IHdhcyB0aGUgTU9OT1RPTklDX0lOQ1JFIGNh
c2UgSSB3YXMgdGhpbmtpbmcgb2YuwqAgVGhhdCdzDQo+IGludGVyZXN0aW5nLCBJIGRpZG4ndCBr
bm93IHRoZSBjbGllbnQgZGlkIHRoYXQuDQo+IA0KDQpJZiB5b3UgbG9vayBhdCB3aGVyZSB3ZSBj
b21wYXJlIHZlcnNpb24gbnVtYmVycywgaXQgaXMgYWx3YXlzIHNvbWUNCnZhcmlhbnQgb2YgdGhl
IGZvbGxvd2luZzoNCg0Kc3RhdGljIGludCBuZnNfaW5vZGVfYXR0cnNfY21wX21vbm90b25pYyhj
b25zdCBzdHJ1Y3QgbmZzX2ZhdHRyICpmYXR0ciwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGlub2RlICppbm9kZSkNCnsNCiAgICAgICAgczY0
IGRpZmYgPSBmYXR0ci0+Y2hhbmdlX2F0dHIgLSBpbm9kZV9wZWVrX2l2ZXJzaW9uX3Jhdyhpbm9k
ZSk7DQogICAgICAgIGlmIChkaWZmID4gMCkNCiAgICAgICAgICAgICAgICByZXR1cm4gMTsNCiAg
ICAgICAgcmV0dXJuIGRpZmYgPT0gMCA/IDAgOiAtMTsNCn0NCg0KaS5lLiB3ZSBkbyBhbiB1bnNp
Z25lZCA2NC1iaXQgc3VidHJhY3Rpb24sIGFuZCB0aGVuIGNhc3QgaXQgdG8gdGhlDQpzaWduZWQg
NjQtYml0IGVxdWl2YWxlbnQgaW4gb3JkZXIgdG8gZmlndXJlIG91dCB3aGljaCBpcyB0aGUgbW9y
ZQ0KcmVjZW50IHZhbHVlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
