Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A594957BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 02:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbiAUBed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 20:34:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13754 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239700AbiAUBed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:34:33 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L04fBZ009111;
        Fri, 21 Jan 2022 01:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nz9z76eePOHQBKxc+J2LprhlPD2pSva6MknnJVMF2fE=;
 b=UNirEomNkDAQbQV/cQBJsnt6XBHKqxv3G58/ccefLeY7bk8ncWtbAcXawSGSKc9xbYo0
 +kG7l40igbfXRoAY2XRcMaGLHQFW9THNAl7waTBH+R26ti8Gm0wsJScinDNcC7kkWPad
 PfRik9/hp+tmdkxeUC2J5PS5J3Aqz1hoIESFNPXXrv2yimkA/Nm0Jq0pKYgtBLs36rkb
 slgFKAfLj8QvXByomn8VFJtAWwBzj1h/n6ya8HfhCQ6Fyefn79F8UmqQ5gS2+PV+6drB
 GAp39ZhvHuMjfriax961xySg8zLRvntvbGyZ+g94/oPgZ3N5Gb9b8q/dsa+AYleQyImP jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhykr3g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 01:33:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20L1Gf5q149490;
        Fri, 21 Jan 2022 01:33:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3dqj0v44jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 01:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeDNKWQv6fsEjCF+sCcXO+67EkEfyQYI2nh4nzjddsN9bhdwT5BbFAPUMYubSCdtEgPDbObf8cYS9fPhS/CDZSDxSt+Pypn/82wehZJPaar7CSYOLBzSGviMTQDyAL0S3qmheTVJ59xz8SsGq6B91m5+mYXTjtdbiww3nYGCVslwIuE7dT3vSc9u8R+LNJdVfP8eZihsOOZaa7TkNbEPwtbB2fZbXY8CGq44hT+CGlPddqzlVhdYy63pgJ88sUFLc/AIVnTswIBGIQi+S0TJ7olqzt0npaWFx9NhvixIN2k66gZA1xCFxfGUGSODj7NqsPP7penqhzgwZ4Um1hgb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz9z76eePOHQBKxc+J2LprhlPD2pSva6MknnJVMF2fE=;
 b=WFwOzcW0s6JcNmKW64C/ItQ+UV1rab4+dHlTJ4tWs5SOA0J5fNhuU4cDntxGtjK8POdIrFcFOZUiCDDanx4INUlDCx+9mwxBcntlhjXoKfVLoRaOpZ1isugA3vfcy9ENl0yGcuOoj7F1SQKU5hKA0dXT6mDm6DBOksAfQOE13alNf0LLfHxD4BagxxIdQDi6MYAKCLEmAPZK+UTz6AR/tCK1ZYIE+KjoHeV1Y0fmoeMbkv2ewju9rFIcs7Q+Pahtpbe+ofL4L5Bdh6we4l9Uxb52IkneudMRdkQpCy0hUlveIj+QiJmim7YtahZSMJLBJOFF/ED6Qpk2YrbSUON8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz9z76eePOHQBKxc+J2LprhlPD2pSva6MknnJVMF2fE=;
 b=HGJTBXnkWyK/aQh5sraWjdl62el3D/aAexi3HAOYqBnSwhAENGXD7Djy7c7nYF71uVzFvxHORWSR0U731MBt5ya+6YdGF9x9rGxod9PPK7Q+HvunYOvT/+823IIzl5S/H3EZMdsbW+MtCiGYrLS5lzBM3drKF5YWGbAUNIpVcHI=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3416.namprd10.prod.outlook.com (2603:10b6:a03:156::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 01:33:41 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 01:33:40 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] DAX poison recovery
Thread-Topic: [PATCH v3 0/7] DAX poison recovery
Thread-Index: AQHYBx1mMl0+u9/A1ECT4doipsHhkaxruVyAgAEGPwA=
Date:   Fri, 21 Jan 2022 01:33:40 +0000
Message-ID: <4e8c454f-ae48-d4a2-27c4-be6ee89fc9b3@oracle.com>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
 <Yekxd1/MboidZo4C@infradead.org>
In-Reply-To: <Yekxd1/MboidZo4C@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62ab09f6-df77-4abd-5e7a-08d9dc7e0dfd
x-ms-traffictypediagnostic: BYAPR10MB3416:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3416AA7C00553D76E27A8136F35B9@BYAPR10MB3416.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kptKr1ZfYX9tXEGhl2khI/TcDWHyNaaFZpIZsMyV4j7Yknww/V8IH8yhXk3Aujk8lANL++BIuLOv5fQwwdyi0G1O41qtX9OV7H6YS9HzN46C1YXji5k/wMr31NuhaxKgAfShRsvm71MsCnTYqXOUUjswACccI38TwLDUJSjpGgLdYxwtWfvYFckgA7mOL0AXBenrfSn3v641ItSQ2Mk8YeEfy/IGy1zEWZEoR3KPYMABCiweW3ETXk9Mx7N4HDz8Vne30+Wk15mKwT0VcgIqN6f/8b1qLhHYl9eme/1YVuEaPdd6Gm8C1mjfMiK6OTphuMr5c3AGrVIuvTaxicK+drm2yMlQrO9AEEzCgCbZJsMZPxf8ih/Sw2GijT3flgNROL53DxIqvYIhmilNSAHWNX4GkLOeYFKS4tAfAxQQqz6busjDbM85UgRJzgCGVqQk+fCWW45IJiBd11IH8nVRl6ZevenLi8r4BKmKHZxr+FYbGgR5h0hDPEoFj/yqy8LRo0DP+m4J7bH2zdJCB1OaxskTnrG/cGT0ZGg648YuVN5/CtGVELrIda9n+WoAdUQ8CClrZ4bsA1QhaXYzmQDkvbRRa/i9jaIfa29v7h+92bn4m2CIXY7tPSJtNjBszRzHGV2PoYkO3DujqcFSPZIn/7gH3dl0pZ4179TUSqRHAnUMLiG2eURGG40i7vJyEazfelOC0egx7EmFdYrzqTR63Y5caGXXtsMi7IRyfIdycEaVXhU0NoeWtcfYFOoPlSDtByqCmc173ZGHTqGn096cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(122000001)(66946007)(38070700005)(7416002)(66446008)(66476007)(66556008)(31686004)(64756008)(91956017)(76116006)(83380400001)(4326008)(54906003)(8936002)(6486002)(53546011)(26005)(6512007)(71200400001)(44832011)(508600001)(186003)(86362001)(6506007)(2906002)(6916009)(8676002)(2616005)(36756003)(4744005)(31696002)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1llWEdiL2lhMUtjdlQveHNnRU9ua0pFdWVtakk2OFVCT1NEYXV3U1JWUk9t?=
 =?utf-8?B?dTgzTTJPTTZDOWhtSHdRSW1EWTNSV3dkMGI2TjJJOG1VNmo2dzF2QjhBOGE4?=
 =?utf-8?B?WSswNk4xWG1Ncmp6VTlOck5SQk5XYUlEeFhlc0F4cXpLMmV4V3N2VC84eTUv?=
 =?utf-8?B?RTBNdHdSVXBRSHZ1cXhnc1U0OUJDQ3NQZFBIMWFSbnJXbFRZYy9sNmk3Z09U?=
 =?utf-8?B?WXhjWlF0T2c0WE5FN2hKWE1vSHowVGNWSmIzVmtJblA1VitpOUdtR2ZUQnNu?=
 =?utf-8?B?bjM2YWZ6ZkkycGZaeGxSeXhVSGFJYU1MSEIvK095MmFhTDBadDlUUHhMWUo1?=
 =?utf-8?B?YUp5VGNwWWdEUDNpbXltazNKTVl4T1VnV3NVRExMNWF4WW5EWUtvM0dtSzJs?=
 =?utf-8?B?ckVjRHc4WWdlV0t6L0k2VzJaRjNwWDFCcThvOGo4d2wzTTArMkp3cG9IRTFv?=
 =?utf-8?B?MmxJcjR4dVZGNy8yNXU4TzJYVVZlK3E3RUVDVm9iS3VLbExUUW9aUU1SS3dI?=
 =?utf-8?B?OWFnbWxSK0FHNm5Cb2t2ZXlFSElQZGxDZWNHMytnTlUwYVM4N0VVNUw1c05i?=
 =?utf-8?B?MnJESVcwaEZwOEtDMkMvN2cxNGM1N3h0UmsvZFRsMVhJeWovcG5odm8rMy9D?=
 =?utf-8?B?NTFtV0RsTzNSYy9VVVFHM1N6bmk0emNRQU5ud1B4VXFuek9pMmljQXBIWDhB?=
 =?utf-8?B?Y3c0RlNEc08wNEpud3kxTUhZRmdTdDdlZWZqZUNCd0xOTGhpeGNBdkVpVFJX?=
 =?utf-8?B?Z0ROTHBTb1ZwbW5jRjg3ekRkVWpTRnYwcDF2WnJSQjZOVVkyYmJBQU1tNStl?=
 =?utf-8?B?SHhsS1ZnMzFQZHA4aElNVURrVVNKc2Z3ZnFaWEVqZTh6N0lXbXIyclNkZjdr?=
 =?utf-8?B?ODNqUDdIdnRWT0lla0pjZ0MzRnJpYTZ5WU1Fb3hLNkZZUlhrYnBzT2h6VWIy?=
 =?utf-8?B?U09NeWViNU4rMmcvUzB6Qm5EbHVVWUZQVmlSN1hwalNJOXd1UWwyeGc5Ynox?=
 =?utf-8?B?cVRwLzNYYnc1eU5Qd2YvSFFGRFY2Y0dXYjBwZGczb0xnZHJNM0ptT0E1VmVS?=
 =?utf-8?B?VWU4bXVRT3RnTkxLSVZDWWxSZ0ozdWVJZDRDSjBzVi90VWR2RitnSHg5U3hM?=
 =?utf-8?B?dGxGZXdXelBvT25tY0Q1K0JxYlpmenJiSlU1WlRYTUw1bGtqOWlJZVRCcTU2?=
 =?utf-8?B?VE91UXFnU0VtblRrVkZIRndWd3ovbU82RnJtMVYwSmxLZnVUeFlURmw3bEhD?=
 =?utf-8?B?VTQzM0t4eXBBOXRSd2VSV0ovNFRhaHJSUHUxc0RET2I0dktMN1hhYStUVkxS?=
 =?utf-8?B?VzNBWEdUMWpYRUVGem5xTEhRSUd6U1hwUlNzNzJNeElpdXM5bkZvc2haN3ZX?=
 =?utf-8?B?L1UxSjk0Z0d1VmtuUWE2N3p1eEFkR0hXYUpsa2xOMnpTbWRXSkFhRHVtZWli?=
 =?utf-8?B?ZDc2QSt3TFB4bFVJVWkxM0hzeFdjTnVRM1VxcTF6UlFROXJTY3dTRWU4NGs3?=
 =?utf-8?B?TVB5dFN5WUgrYkVNMS9tYlpqanZpZmNkb3E2VTRadVk5bFl1ZE1LMzZadnZw?=
 =?utf-8?B?b0hVL1Mvb0F1aEpKM1ZRMjJOcmh4OWZZVkJhS0tIZ2prTzk0TFl5OVhOM01H?=
 =?utf-8?B?TFB2VGp6d2JZUjNQUEkyMDRsUjFGU3VrbnU2R2RQY1dZbHpUK3hDcHpzMXVJ?=
 =?utf-8?B?K1p4NWtJVkZlRzl6SnJKSVlDK2p6M2VIM25kdEFSMXhtMGZFQnZoQzl3M09z?=
 =?utf-8?B?ZmpEVTV3ZFMzS1RWZEFwakRBRjZYZHRod3BpeDFZaWJpMTVIOVUzRVZaWDB2?=
 =?utf-8?B?UzBVeFBSaG5oK2NURG12Njdvd0IzMTR6aWJtZDlZcjJOWFB5NXd5RmwrUnpQ?=
 =?utf-8?B?aGpoNWxVRDYrcW81TlZkcUcxT1M1bzhBS09Iby9weGlKeVlkM1d4cDRQK0No?=
 =?utf-8?B?WFpjNWRZbzNqOWVkdWFiQStjSkxCRnZZNHhqR0RZVzlSMTFSUHFwbEFZRXl1?=
 =?utf-8?B?QXBUWEZmOVlNUWFXZ2RxbWw4cXpnS3pvaStSWjE3Vk5ubXQ1ejl1QkFZK1Iz?=
 =?utf-8?B?bnFzelQ3TzRzL2dqZXp3dnEwY0U4cG9iaHd6dEl5OXM2UGhSZEV2SUc3WDhJ?=
 =?utf-8?B?aFluMEJ5Vkk3OVFaZy8vRW9YYjFySHJGYWswSE9mdTJQMU9CQVZpQ214OGR2?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <396EEA0745EEFD478E3B0075A7BC352C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ab09f6-df77-4abd-5e7a-08d9dc7e0dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 01:33:40.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7S1G3nsvht63tEJ+rDdBjJSIu6MuN4vcoNL9tF6yNnuUnaRpqAWkkOeRuSVVHT5RhV9j6pDbh7FIqzo7mdfWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3416
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=689 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210007
X-Proofpoint-ORIG-GUID: -MARQZfwuS1E-4RihTH0MQuHZMQwDv4P
X-Proofpoint-GUID: -MARQZfwuS1E-4RihTH0MQuHZMQwDv4P
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8yMC8yMDIyIDE6NTUgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUs
IEphbiAxMSwgMjAyMiBhdCAxMTo1OToyM0FNIC0wNzAwLCBKYW5lIENodSB3cm90ZToNCj4+IElu
IHYzLCBkYXggcmVjb3ZlcnkgY29kZSBwYXRoIGlzIGluZGVwZW5kZW50IG9mIHRoYXQgb2YNCj4+
IG5vcm1hbCB3cml0ZS4gQ29tcGV0aW5nIGRheCByZWNvdmVyeSB0aHJlYWRzIGFyZSBzZXJpYWxp
emVkLA0KPj4gcmFjaW5nIHJlYWQgdGhyZWFkcyBhcmUgZ3VhcmFudGVlZCBub3Qgb3ZlcmxhcHBp
bmcgd2l0aCB0aGUNCj4+IHJlY292ZXJ5IHByb2Nlc3MuDQo+Pg0KPj4gSW4gdGhpcyBwaGFzZSwg
dGhlIHJlY292ZXJ5IGdyYW51bGFyaXR5IGlzIHBhZ2UsIGZ1dHVyZSBwYXRjaA0KPj4gd2lsbCBl
eHBsb3JlIHJlY292ZXJ5IGluIGZpbmVyIGdyYW51bGFyaXR5Lg0KPiANCj4gV2hhdCB0cmVlIGlz
IHRoaXMgYWdhaW5zdD8gSSBjYW4ndCBhcHBseSBpdCB0byBlaXRoZXIgNS4xNiBvciBMaW51cycN
Cj4gY3VycmVudCB0cmVlLg0KDQpJdCB3YXMgYmFzZWQgb24geW91ciAnZGF4LWJsb2NrLWNsZWFu
dXAnIGJyYW5jaCBhIHdoaWxlIGJhY2suDQoNCnRoYW5rcywNCi1qYW5lDQoNCg==
