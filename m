Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE67A40B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 07:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbjIRFyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 01:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbjIRFy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:54:27 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0BC4;
        Sun, 17 Sep 2023 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695016462; x=1726552462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=nzoeiBPGJvxRe65Oxgx70n8l28pD+ZuljXvC9qt4wfONjUs+1swf3IOP
   YVgz/jXjdVK2uarTrbEci6TyT6XqBprfESMhCGMWmw8UrysulwuwC/A57
   A5nAAb6h4aPJyYbVYabc+8r9LG7I87Ke3cntTPAGblwdYFes/GTHPZru/
   GXN5ptiBt4Yyt+gV61Kgn9qvHkJGpVyX6J2xAbyReTLTlHlA6GAvb6E2u
   0NzeoMAoxn0Kh9KctGRXKBSMgtf7TbYVl6rrf6yPQCGVSroeEDJW6KkXZ
   8HiS53hPSuQhSoV3qjTIRgP02+L6zrowCaCbaxQFtiPljBkB1KLYLPpr1
   w==;
X-CSE-ConnectionGUID: +cwFqimaTiecJ4yFIBAdVQ==
X-CSE-MsgGUID: lfde7JSwQJS1ZAtgB29oSw==
X-IronPort-AV: E=Sophos;i="6.02,155,1688400000"; 
   d="scan'208";a="244536943"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 13:54:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ7e5wpfzwS3qg/nuo5qA6K5gDgPHMN4H/sishzop2Go8MEzk+PDigaljWZUjw566uFL28oVZGjeqcp8LY0kcSug8NXoU0Ids1BSze0Xzx2qixJ+/ScObs54bns8shg/HGTuOYOiuFWmB92FHh6Et9SY7Qb959OTodRd8KDAnX2jVFt+Df8TVACRhVkYoFeEqrLQM5PFvpeA5AsMF5eYylNxht0QV1aa6bweEXjtPxzPLK+iuC6Ubbo/0kPNFAP60Toetb2pbXB2vusX9VHznI2+os4isaTBdca48t5JIDxMLMCFxke9KQpFSfcNzCUqZx4QJfy0aM4Peqph1BeAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=m4Jl5aSJ/m6/5GZaILEqAzeJjQ51yXV67jqyrD2+CRT72T/WV+1qu+vl5pbSNs+9sS9IvwtlPlIiKGzTtIynUgSVrhCldvTox/G9BUPKtCsdUsuw2jehudloFDz5/vz47BHk6TLvQKoJMtswZppFW8SCIHFiYqRxDJqF0wmxdkAxS5BkwrshF3g8ivxzNoSwz9YQVrPrtAfmeGU4b3u5BgM7SC8aX4I9VzKJvWtVh3oeU1lgg0HQ8tfeiPgWnCjCFU8+JKJ4hubTIpByqPSqetg75CiIRrZ2ri8TtT6jbG4VwrXw+TQYZfyCdTdPaPTa4m+v8XrWrQ+6oYkbgLgpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=q3FIbstVEU4G9F5Ja0aLX4OlBFG6wOnSmJff6LIn7tNilXSbMaWLGb8ORDDq7td2ILJbhJbtyGmADP/gJpPU9dzqXcUOxrZqA16a1NGjD3l/pSPMO13m1KriKZJGEZlxbvytAkox8w6HzAsLPIpzqd3hZKNXTzwGPXfCjZVendo=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.15; Mon, 18 Sep
 2023 05:54:18 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::eaec:d76:ea35:5df6]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::eaec:d76:ea35:5df6%3]) with mapi id 15.20.6813.014; Mon, 18 Sep 2023
 05:54:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
        "christoph.boehmwalder@linbit.com" <christoph.boehmwalder@linbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hare@suse.de" <hare@suse.de>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "da.gomez@samsung.com" <da.gomez@samsung.com>,
        "rohan.puri@samsung.com" <rohan.puri@samsung.com>,
        "rpuri.linux@gmail.com" <rpuri.linux@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH v3 3/4] dm bufio: simplify by using PAGE_SECTORS_SHIFT
Thread-Topic: [PATCH v3 3/4] dm bufio: simplify by using PAGE_SECTORS_SHIFT
Thread-Index: AQHZ6CZPxuZqQqsR6E6WTQG3iAZId7AgGNMA
Date:   Mon, 18 Sep 2023 05:54:18 +0000
Message-ID: <21eda285-ae28-49c6-85d7-fd5a65d87627@wdc.com>
References: <20230915224343.2740317-1-mcgrof@kernel.org>
 <20230915224343.2740317-4-mcgrof@kernel.org>
In-Reply-To: <20230915224343.2740317-4-mcgrof@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7653:EE_
x-ms-office365-filtering-correlation-id: 082e1440-49d2-4bb7-faba-08dbb80bb2c6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiR24DgEXeUm1QO7/TSNFTQiqH8QGzbCr/1TyaId3S9u+LBvA82H9wSoR0SumFKTWj+pgmYtTgJLaCsaRyK8RcSwRnwu2V6qtrpIwCYZ4TpcCKezGCVEVxhXFXjeRTV98hbV4XX7ZkFjsAtsR4S6K2RozbrJsh0u4bTEASB0U3vdJWirf9LqvMy/L5fN5oKJAzftGexvj6DOa3iKzf1JrGRzJeLx72sF/E7AGvkHcoJfLvz6qon+Gd0fMze8mzWATO1T7NLvemdflNB044Rpdswin1iNQxEmyEYh3qxEtdH7xweoAZjQZn86GNfx8cKbu8NSV1HaHEcwPpgbJIZB8DPmd8+OU5wbx9CB3RyEJWaPSRaCkBNOVe7fmUF/5tqkdrf6sT4dzAV7VacbziaqjEBz9P6EAEmAF1z7hw2dTBDKPtzgiPJZBHnxXg+HNweSaJdFSXU2NpVD0hCYVyq/1QIUTnYD6kG5kJqiu+cnIMfxQB8/fglmLRwbnb5YxFfyhlXKdvJ/0khfCkJEL1xd7hZQjWcpqvDj0b8NevnxCyAEUu/CN/efv6zc+z3EUXHmVQad7iSEW0u5yundeqjJxQ69fnp5hyOXsBT/85iLEXafZfBlnMBgTEG8O+QYqbh5kaog0QZc7NFqopn0WiLvzU//G90ZkAqbsQ7MDleZ2UaXeuMxc6WABx7/IAyK7fHhpOLq68OQlgJHn3ltlo/dXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(31686004)(6486002)(6506007)(38070700005)(558084003)(86362001)(31696002)(122000001)(38100700002)(36756003)(921005)(82960400001)(2616005)(4270600006)(19618925003)(2906002)(71200400001)(6512007)(478600001)(5660300002)(8676002)(4326008)(110136005)(91956017)(8936002)(41300700001)(316002)(7416002)(64756008)(54906003)(66446008)(66476007)(76116006)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG1ZcCsrWkcySGlySEpuT1dBQVM5K2lJZFFXczNkY1dQL0FnejlWUXVydFJt?=
 =?utf-8?B?RGhEQS9nbURkUmd2YWJhL3BkeVZlcjNMUXVKZXBsNmVHR1BJdTlpbEozZ2lm?=
 =?utf-8?B?VUl0VlBxeTZkbEt6dzR0dk5Ieml1OGZJNFB3aElsbXNJKzFNa0VmaTMwZG1h?=
 =?utf-8?B?QnY1WHhnbXg5UmN5Z2RHSGxCVWk4R2VST3g3YnRtajZsVklsc2JvVmI0NDg0?=
 =?utf-8?B?emREelA3N0JQcTRJR1RyYzZDbmJaeUxpMDNGaUtxYnVxaUR6VDJObGY3M3py?=
 =?utf-8?B?WGRkUTdkMnpJM0xFTWc5UkdrcmxvNlEvaEJLajVITTk5cFIxTmp0aVBBY3Np?=
 =?utf-8?B?YVd1SGZhb1dpWCtaSUZkMWZFUXUxM2x3c3hETlZCbjVmYzNCajNhbXpodlBV?=
 =?utf-8?B?T2gvRnJ1cVhKeXpkdktKVE9NTEFIKzQ4QitsSDE1bWExWFlKUkxYTElBZ0Rt?=
 =?utf-8?B?OFRVV1V1MDJUOVJWZW5kVVdFY3dPbjNXR0FMQ2hyVVdCNFZJTHZlL0lEZlhX?=
 =?utf-8?B?V2I2U28vQ08vOWdWWDlzY05ZS2NPOVU4TEgvRWkvc1R6ckh5WEw2alUxR296?=
 =?utf-8?B?YXg0bEVqWnBOMGdZRXd4cmtWdGdSL2Rna09kdUp1R29RUGx3Q3MwZXFUVzFl?=
 =?utf-8?B?cVdWMFBsWnVYeFZQeUM4VDFMMGNhVE1rSHR4UjNZTWcraUwzNHpQTWV1THFO?=
 =?utf-8?B?Ny8yQ0ZTV29qT25KdVB1RDNDTVpaeHovRUJIRDhnM0RtVHdPbVFaWGhTazEw?=
 =?utf-8?B?NHd4MnRpblc0L0t6TEZjdEcrT3FKRGE3a0tzVjRhbU5OODdjRlVsZjVXWnkz?=
 =?utf-8?B?MEZweDAzWjNLUzczZDlUcjVnWmxNNFlna2IxVkMveVd5dXpUK1JQWnY4dWRQ?=
 =?utf-8?B?bXYxaUpNS082cFlkNnpJY1FwUzdpaldzekxUNkM4cTc0bkhyM1dORjlhSHF2?=
 =?utf-8?B?dFJleTg1cnlSMFJzQjlTRDRocHZhWVRNYUdSZzc1VmxYSE04KzV1c251TDZQ?=
 =?utf-8?B?YWNHbE01TlJkSE5YQnNpT0hGSzNXZ1ZiYnR6ckxkeVd2YmNCVDdiM1NLNExO?=
 =?utf-8?B?aWxLeFJxS1drY25QUmFTZ09wa3ljMVJpSTA4NitPZjBvYjNEZURFYm1raEFN?=
 =?utf-8?B?NlJuN2dCdjRnbDJxVmhoclgzb2VqSS9BMnpDZ2xEU3Z0RlJFZlJuMHpReXdI?=
 =?utf-8?B?SWYvUk1MUk9FTGc5V2krRENWYzRWdllzZFcrODVsOHdHQTdvd1dwdG9xMFhh?=
 =?utf-8?B?OW5MSzJ4Sy9zNlZxSjkzVWlEaTMzYll6UkFmSW5JaFIwTmJxdHB6WFlYeC9K?=
 =?utf-8?B?ZkVwVVhsclBoS0R5WFdSc2Jtd3BZT2xzQVR4anZaM3pzQlMrVmF0U0hRRXNQ?=
 =?utf-8?B?TWZXMHcrTHNlUk5kd1h3VlBwUWVOTHIwWmYyNHdFak9SOU5udDgzWmJCSE16?=
 =?utf-8?B?YVpIU0M5TnRCTlVuSFNGUllaRWlNNEg4K2RIekVxQlRORHRqNEdMMnpkMWpU?=
 =?utf-8?B?c2YvbW9XbCtGcHFyYXBjSm9KMGMxOVgwQVJPK0JuNGN2M0NOMFdadXlVN01G?=
 =?utf-8?B?dWNkOHBFZEhTYU9PMXliN2JwSStHQVROeVgzcVNxMi9uU2Qzdkk2cXpiVUVk?=
 =?utf-8?B?MkZHd09ucm5maUxvbFRtV1pxRnpRZFFJam9HY2NhK2plT2VjdUdZZGxNYThT?=
 =?utf-8?B?bEVMSklFMEJ5by9aLys2cmw1UTd0aGlTaXZOZWtSRzdKK0VDeitPdzBQK2xp?=
 =?utf-8?B?VXo1b0FwL0ZCSVNZb1RGdlJZc3J5Qml6aVR3dFNaQlZYK05ib1pXVkh2UkNu?=
 =?utf-8?B?dUtQNytDQ1p3SVBtUnVuSUVXYy9WUFNJK2JOTjlVVkpYYUNiYWFYSC9kNGZ4?=
 =?utf-8?B?YnNBMUhpM291d05HQjVBRXFSRCs3dUxmb2crbDZsL0NaZlZLRVJGV3hOMEZ5?=
 =?utf-8?B?REphTGowQVRVSHMrdGtGVTdlYVRkQ2FMWnRTeWRIeUpXc1ZKUkRCUytIYUxy?=
 =?utf-8?B?M01SaTVJWmlLajF2OTF1Ymh3cW8wTVpocWMxLzloZGV5LzljK1IwVjV4d2pE?=
 =?utf-8?B?UlNsWmlHSmlKWm1ncUdXeFpnRUNPUEQrYi93OFNqcmNWV2hobnRkUU5MTFhS?=
 =?utf-8?B?ejJOdkcyWU9OdVQvdEpXMms1MllQcmJqZ080eXUrWjVJOGgrUkdjUzA0b1pW?=
 =?utf-8?B?aEtuUzNMcW9xZzBod0J4eG1GK3QzN0RuSmZFL0V0UEdCaWJKQjVqRURRbnp4?=
 =?utf-8?B?RzRyTDZ2NmpoRWZXcDlVM05hREhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79F13BC7846AFB40974AEF3B4BF998B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZnBqL09uZ2RENmtqY2xRTWhNL29ldkViK3Y4bFJSQi9EU0FaSlpLelVmdVpp?=
 =?utf-8?B?YjFPTHdxTE1Bdld1SjVDZTcwYmVOSkVFdHQvVVloY0YzVTFwZkFrWVE0dDZJ?=
 =?utf-8?B?MUd0ZjhqUUtIekdSTURlTlp2dTBtMlR6T3Z4UWJmYzZFRklFcUNBQ2NIN3R1?=
 =?utf-8?B?RFloZ00zblZwanJVTXBRS015QmlSdENXbk5qanlaaktDWng2eEVsNXFrWCsz?=
 =?utf-8?B?NHF6YmNvelozUDVOZTFjTlZRejJjVlQzRzJpRUFXZ2p4blNVeTFYVTRkTW51?=
 =?utf-8?B?Z3dralljVXBNOEJZK29kYkJWVHZNMkVkM2dueGl2MkZtQWR6SS9WQUlqR1ZR?=
 =?utf-8?B?eHd4bWdISGtFcG51eDM0c05uMWxPbTFMcWZ1b0Q3N0hVVWNLMG8yRFlmdThH?=
 =?utf-8?B?TUlPZ2dEYU9wWm9FZm5YYlZXL05icmNUQW84RzVUNXlENlFSUFBIM3VEWmh6?=
 =?utf-8?B?RXdMYTNNTlI0TklLYk1MUlZNNFU5bUcvcjQyUkI1eUgycDdkbk5kMnF4bUhh?=
 =?utf-8?B?ZEMvZmU3Sndma3oxUFJSV0lnRE5xT3JvakhQVC9vc1ZvMUxyeTRWWVpOQXpN?=
 =?utf-8?B?cUkyS0ZaTFo0ZUdYOUZRbFI2M3dLeTZpbVRLV2RLaUJaQXhWdU1DeUJLNWow?=
 =?utf-8?B?RUhOd1paY295K0pIOVBlSkVXaVhqWmM0dXkrcjVNelRiRUlYajk0bHZUR21U?=
 =?utf-8?B?K0c0M0RpQ0p4eE9yY0lJQ0tVVW1xMHkrK3ZSNEhjcUhGQkNiSDdiZHduMUdy?=
 =?utf-8?B?dTE0NVFlTUdEOVF0MVh4Vk50OEdNSG8zUGtBTmNQaVNwTjZ3d1B6b013eGc0?=
 =?utf-8?B?dUduMWxlVG9Ob2IwU0k3ZlBaRHNEdDhDOXIvZ2J3ckYyRjBuWHR6YW5tY1Fu?=
 =?utf-8?B?Nk5JMFBkWk54cFdPS3A3emQrTlBtd1FkWFR1eG8wTVRMM2p6VG1MWmtKaU5S?=
 =?utf-8?B?cUdUYXk0a01aN1RER0x1Rjl1Tm9xZEl3TXFkQXpYaUVPNUtFYkxVR2dkQUl3?=
 =?utf-8?B?RjhiSVN5dzBHdW0zOC80dGNtRmd4L1paQ3JWUXdTYmd3NmY0TUR3Y2FKWlRq?=
 =?utf-8?B?NENlNGo0U1FKZEl0a0hDeEphUlR4M29TaE5lVUJSdVo0ai9kQmVUK1gwM28r?=
 =?utf-8?B?OTVxbmFvUVFsdG81T1B6OWZPMzNnQi9oMGUwRG52Z1Z6RENTTjUxTzVVVERs?=
 =?utf-8?B?YWlTVzdFSVdiREg5eFAweDgrLzJXajh6TUVVaVdBaXVVVFpQZ0NBRjJlaENr?=
 =?utf-8?B?cmJicnpVOFVjbjRWNHY3MkRwTmtESXNYUmNYZHlvbFpLbExpcHN4c1MzTWxy?=
 =?utf-8?B?Ung5RjhqamdFeXJ6NWphOFJKQ29KNWxXaFhManVLQkxvemtERjdnZEtCV1pZ?=
 =?utf-8?B?RXlhcU5rNnVLUjZqVGlPbXlxWlV4UjF1NU1rZ3pibkRhbERGODNuMERiT3BT?=
 =?utf-8?B?MWwrWThMcEJ5WkNQUlRnYnBxMW5jTzA1S1NLSWd1NzFFamJEa1dUQkVPcHNS?=
 =?utf-8?B?RFVFdXBxYUFyUVNkNjRTdkcyZTNXNGFDRFRGWXFKdEFKOWNsWmcyaUxTeEhC?=
 =?utf-8?B?elV4dz09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082e1440-49d2-4bb7-faba-08dbb80bb2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 05:54:18.6229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Er/Kx0FPjrxARXcEJnRV1FnkmsKeNev//7wgZ5Q3FUlw0TgTdTUcrBOUX8upO09uc5VXhmRz7dhJgVSZyyukRUwW1nTN0x+to4xEf0TnHxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
