Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2AD75B0FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGTOOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjGTOOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:14:36 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F52211F;
        Thu, 20 Jul 2023 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689862473; x=1721398473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=KaIb1MKbGTs3dCaxjS0utsaPnvWxpGoC2SjaWpxFVmAYUaqMUP1RV2Ee
   FkDpoWqst3g4/CN31rvmqa3591wB+j8A/T+QWqtP3QR93fly0xGTg45G/
   lq9yF2IlabjXBUovYfGnNiKsdxgJB3Gb2oGQiDNa01veBt1cu5b8oLjW9
   GlJfxUpHnLg/r/T5pG44S1EYKqIoFmVVAUyo+7L94aSk9oSXvAjf7o7My
   VReNl/eii2yL7LMeR7GMwccnRZmXSS2ynXL9fT509B5MunWBf4vJc02FF
   ZP+dTIKl2D2ebpVDaZ60SsjFU10Tcnq4aEviGUcyjzLo1QqXQK7zdklqT
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,219,1684771200"; 
   d="scan'208";a="343692798"
Received: from mail-dm6nam04lp2043.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2023 22:14:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ6IO9pQ0K4EjA94tDYAc5A+mHcq8MUrJWGVsc3/lk6Bxc+PNUpIbOldhnbksS3kWWnkaqjoIXfR5A90pnHxBGFqa4GIxUDsE2j/FfaVZ7zVBBt55X/UdZepJce+PXeReBJfGsZM+7lnkgRhpVV8AOTGzGw4jAEysR22vhyilTpHwRnWWpEzF682HxGk5O6Zp6OFmINPpDBumKNCTveNJN3Himwq21LMz9qDgoBW0efTjt1hdi+/0PCNEHYoVvGfj8QjciyMOk+I+RdNl5UmNzMukIGSouNuaZqS8bNJiQN+k76ROkpyu1ZXdOXKiWuZ5DOUdyVfe3dTm53qo0hxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Yx7Dx5V6IiIgGsAcskNtuKESr+tCTW8jCEKyAKg18g7/lXX2n2LrVE15+Mr0aFGdE/scUgJtsASAV8K31jepCqW2D3IBiOcoJ7rDei49sevqHF5SYsDxr4PGtw/BZuFhWPXhyaHfZhay6mQAGyZtY69E6T7NLLw3uTyd+/uDGYc9NGfbH4mkHddWIA+4eK5U2YgznrlYxt1bTWxSpt/W+aMGH0Obu1R+Dlt+n2b7bqsTVZy6umuMvz+Ql1cH03LU9hPc88rhyZ/yS4t2qhTFqERk9z5bvmqcZuxgOPFdv7i6cVqvF0s6AG3d6V0BKqFIiS2si5/Bi7AyEuhQSkRdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dUNcuQuYCN4kiptu5wR143yslFxEadcLpcRqa0l4vDHUAhch9uyuC1veSmFkfgbj9XLzRE/zUfaRP/Rx0wSs9Yj7fL1yUvLgStWAErTudU5+cgcusZHH4LkKH7itsrmLC9gdnuZw1qoD0ETco58yV4uu7WghgTNwFiuKFWD6RWU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7615.namprd04.prod.outlook.com (2603:10b6:a03:32b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 14:14:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 14:14:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] block: open code __generic_file_write_iter for blkdev
 writes
Thread-Topic: [PATCH 3/6] block: open code __generic_file_write_iter for
 blkdev writes
Thread-Index: AQHZuxNAkwfYrjnF8UmZO5DlP5Du26/CstYA
Date:   Thu, 20 Jul 2023 14:14:29 +0000
Message-ID: <19c737c7-8a62-5688-e279-1587b4d6b5d7@wdc.com>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-4-hch@lst.de>
In-Reply-To: <20230720140452.63817-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7615:EE_
x-ms-office365-filtering-correlation-id: 3d5894eb-3115-46a9-e46d-08db892ba1c4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4LLSjwwCAgLYb/fNw0Wx40IPIQkmIXEycgclL6WrIb26Qg3uvtdO61nUZcWEEP2pSJiQ1285vdZDVHF58HbA/g+V/Jw6EctMl2XpKEYLLdUwiurBVDzMaTkIg3PHVgBL7J8kxmJertboh+82cV9SRA/02QDnvRwHrlJG5dfm5koF8sj1VIVN6Sij+R30giK6bOp8RY9xcKTVeae8zKPVh12UUPgyeHYhumpgm/RG5DYYvnPBu8WaawqEJxMdKbrdc6q9qK6lKc1QyMjJZoiKx3XS1fMgv2ykjwMjokuY5OC772txljyZYvVg88ISpQ8szeDW4EW8djog2N7Gb14WJKIO7ykn4kFIcM/Jze3oVbhv4+g1W1U++mgE9SrBNSZ2Rer+3y02pAQ+4KbHO/z41zQ3ChU7oj2XLK3QNJdURKPf3eV9YHAON/L+qBVLWVpXb3cAobtKC3TFUwkNfXRgV9ywBDvvWwZYOpW3ZljG4NcwvP6tUymDh9LQPvho5QqPQkUMuz6Tj76YKJLfMAp2KGPbwIBreeFtEaBMH/tw0hkmZSe+XNeUBzpiqYtJJ24mSVq9wfBnzVwtuT3q+NIviZyuBdgb21/oh+EyfOsJwvNC54MbKFzizMpf2xAJpwaEediFiNqSxu1SFseVfffn7qaGimKZ9uaE/W6k1xI2jIDlQD8WZL3xY2OhV6CVES8P7kdJQg5QTEwtGmwWVb9yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(71200400001)(4270600006)(31686004)(4326008)(6512007)(316002)(41300700001)(26005)(6506007)(186003)(54906003)(110136005)(5660300002)(6486002)(66556008)(66446008)(66946007)(66476007)(64756008)(8676002)(7416002)(8936002)(91956017)(76116006)(478600001)(19618925003)(2616005)(2906002)(38100700002)(38070700005)(122000001)(82960400001)(86362001)(36756003)(31696002)(558084003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TElXcXN1NlJ5ckc0aTNVcXhFL2UxMUhkbG42OGZEMDh3VWVPNE5oMmoxdXRN?=
 =?utf-8?B?dk5SQTMwaVVJaFdkTGRhQk8yaDB2RElhTGw2clZSamR0eDFrcnVRZ1dZUkZG?=
 =?utf-8?B?MmVQTERGN0xBbXJQYlJoeThwSVFvSml5c3pMQkkxWDBIaWRYaFhJMSsvd1dh?=
 =?utf-8?B?VXBKclFuK0p6MUZEZTF6Nnd6ZlJkbjNJNHkrWFpHdyt0dG00Z3R6TzlnTFVu?=
 =?utf-8?B?aTNXMmp5MWNndUZKSld0ek8zQkNCMkVZeW9WVnVvQTBlcUEzaFZmRU1Ed0tJ?=
 =?utf-8?B?NGNvMVVCUmZueU1wY1BESWFLT3JMS0hsdi9kTW1aLzBMb2I1MkJQbUtwY1J0?=
 =?utf-8?B?MWRMeUp0RThHZ2lqRnMvdkVtVlFHc3FUMEQ1cDBXNVZWN09scmN4V1VOVEdS?=
 =?utf-8?B?amIycVJHUGk0ZnNZZFFvVHYvNzhWZ0RTVEc4YkVtRkcwTzh4R1BoYXpmbUFU?=
 =?utf-8?B?VnA4SjlBdFBWUDU2NTVCYjlpUGFlaTNjM3QwZFhxajNMWmtmcVU5NDhGYTBt?=
 =?utf-8?B?cXZrSnFLb29ub2tDZnNManRnSEN1azMzL3BBaXVvR3AwYzh3d2xseWJveFRE?=
 =?utf-8?B?QklTblErMlh6TExPMmZ2K1ZGOFBjYkllWlI2SlVTV0N5bmVzNUIyanVmWlMw?=
 =?utf-8?B?NFFYWU10VDdEZU1CcXNvN281OEhVdkp4WVlwS0ViWHdNRkRJajBHYUNVSTZr?=
 =?utf-8?B?elNITUdubHNCaVFtcWVRQnlpKzhZeTNTMWd5c3BPc2Z5cXlodFpFNVNJTEIx?=
 =?utf-8?B?Zmg2MTZsbzZsb0pLV0lQbU9TaVFFWnppcnZVUlU1QjF6MDl3a212THM1a1l0?=
 =?utf-8?B?Yzh0dXkrekFGRis5dzVBTnZmU3pNam1PUVpoT25reTJjL1VKQmhHWFRnNjYx?=
 =?utf-8?B?bjBSU1dnbTl5bEZzd2k3MkdPTDcvYUc3SzB3alBFdkJPK0J2czdNSEVrQ3NC?=
 =?utf-8?B?dDdOZnVpQ3BTVS9yT0dnWmYyYjJNWUZUajVneExGZ0RPRU1Oa3FLRmlRUXFq?=
 =?utf-8?B?OUozQVFZL2x4YXJ3VDg1SW9XSHBPdEtnOStHbUFPQ1dqQlNiWmtzeFkvY1pC?=
 =?utf-8?B?akNMaTY2YkpYcEd4YmFLSmFqeXoxSHhCT0ZxQmZnanh3SDRyOXVtcVBQbG12?=
 =?utf-8?B?ZnBFbDcvU1V6b0ZXZk5NMEYrUHpMbDk1VmNxclhJeFpBdFczU2NyNlhMTUxY?=
 =?utf-8?B?TE5Xak5hL0lua3pMVHBWWi9iUE5YOExmMzRURmxXbWN6Q3g4YjN6N1F2ZzM2?=
 =?utf-8?B?TUtCdTIvMktWTEROdDU4NlAwcnRXeUV5V0NJRytLUlIyTzU5NUFCRW9mNjQ5?=
 =?utf-8?B?aHcyUzV1M0lmaWRlZnRqTmdicUp5Uk1iV2dQeWFQNi9tSVRzNVcyWXdxQ0c0?=
 =?utf-8?B?MW9yYUF1N3dUQVN4RTVic2tPdlYxMENCUUJ0SnB2NFBKMWN4NW9xY212dUky?=
 =?utf-8?B?c1RnT3BsVGhFS2VTSDh3RXBTZThwZlpnUTIya3hheGZ5cDF3RDduRVZ2NVpu?=
 =?utf-8?B?R1gvK094T1JsalZHVGRYM0EvRUZJZXkxMGcvK0swNFFpdDBISnZ4NXdIeHp1?=
 =?utf-8?B?eXgzakEvQzJYZW1Ec3g1Q2dNMUtPRDdYRE9JbkNpcm8xWXVBSjhwbFcvaHpn?=
 =?utf-8?B?YnRIcjdTV0dKQjlVMlRqZytMK1NBZlBDWGo2dDhqdU1ieGZqSmladkNKQXAr?=
 =?utf-8?B?blJSOXdRTDJZbnZzSUxZcnk0V1dsaXFPcCtrR1hmNzhCQlRVcWwyZElJb3Fz?=
 =?utf-8?B?MStVdEZOekxjdDZWSWlSYWoxMXJJSXNRdlJNSDd5Z0lBVk8wM3RzMWtLOUtu?=
 =?utf-8?B?elRwU29sU3hna0poc3VzdXp3VUlkblhocXlGZGJqVndnK1JSMGZLNEtCNjl4?=
 =?utf-8?B?cUdmZWtWY1NiaEw3VnZVRkNqZGt4c1Z3d1lZZ3lyM08zUzlKeXVUbkRTY3A5?=
 =?utf-8?B?RTgrcDkwS2VyUnVKYmZPT3Ayb1E0UWloTWVYakZKMzg5d3hkdlJpaER0L1R6?=
 =?utf-8?B?TzFIclhkMjNQOFpEMGZyZDJrUmtRRXdYVjhlK05RNk0wWFl1Nm8xMHJicGpG?=
 =?utf-8?B?MGxDbWJjdjd5dE8vcHJjRTZRcWxjMEVIdzhLUjYvUXBueVFuQnFZUStUK3Zw?=
 =?utf-8?B?SnpsbmltVGYvcXBZMFU5Y1JXaTUwdUlWeHNRNml1aFJMVkp0S0Z5cmp0QUYx?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A38DD0537ACFC84A8121054649D7C3D7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UHdPdERwcGdra2N1T0JXZ1Zyb29SL2dCTWZWV1RlQUlNR1NYQldGM3dEY0FE?=
 =?utf-8?B?Y3FDSlUyM2ZQbjVUczFDNm5JSDlmWkdVdFh5ekM2blIxbldoeEZsUkdObDdk?=
 =?utf-8?B?M255T1NKRDIzT0lKTFQxRklXSXJabUJZRXpoNUVKZTNxN1RNckJON2hJNnd2?=
 =?utf-8?B?c1luWDVBRUxxRUJMbThmYjVUMzl5aUpsRHFkVU5ZTWFmQk5aVlgvZjRnRW9w?=
 =?utf-8?B?QzNPZWk4d0J3TnNWYmcyVDJqcDRpV2E0N29qQnNSL3lBZmsveDdQU2sxQjFM?=
 =?utf-8?B?di82NzZFMFdVTmxmTXd3WllDWEJ1WnFlV2VYS2VtZVFWbFY2MWVVTmk5VS8x?=
 =?utf-8?B?TG4xd09GVWFnL3JhTG13aFJCNDVhYXBQdGFBVy8wVFQxODJBUzVQdEFLME1G?=
 =?utf-8?B?U3NDQ3hoMDlDTGJsZitwT2lvMVBzQmI2R1lEa29OdG5tT2tqN213TVprT0V2?=
 =?utf-8?B?TTJsa05ZblkzU2RBZnpxWWgwZG5zbVJhWUFoZXRQaDBrUWJCOVVkcUpaNG9X?=
 =?utf-8?B?UHZJc0l0alFNT2lpZTJxNldlbmNSR1pTVittY1h3LzBybGh3SGpCdWZBMGV6?=
 =?utf-8?B?MnVnSFJTTjhLN25jWXBaQlp2bUtaSm0wNUFCRXlEaldHZmRpYkhnWTgwdWhI?=
 =?utf-8?B?R3F5NXFTTytrb1NvcTVvWlNFeVFWS0lFQWQxMVAyMklvT2ZRQ09xVzZxcDA2?=
 =?utf-8?B?U21hTFZoNjJpL2tmUndHd3dQRXdnczFsa044aDdJZWdOYStyRm1rZjRvMUxo?=
 =?utf-8?B?MkhCNk9BclpVWFRDaTF3WGNZVnpobWpUWCtFcXI5alBadkJ3czdZTlZldGRi?=
 =?utf-8?B?VUtrbUp4MUhSRkpaNUMvTXpNK1o4VmtNMVZZSDBtQm1zVjdwMFFlWmJPREVU?=
 =?utf-8?B?YVNSbFVSZ3RQOVFSTFJzOUg3cUttSzhpY2tIanIyVjdZbXJXbVQrdlRySDkr?=
 =?utf-8?B?ZHpucXZhRXc1T1F2Y3ZwMG83ZHlycmtOOTZKS3pYVk5lRTM0czhDbzBpK1Ex?=
 =?utf-8?B?a1JxbGpFOE5Ub0J4VDM5NjBoQ1VJYmtISHJQNytoUEg5dzI1WVNmdGVrK0U5?=
 =?utf-8?B?am0xZ3Y0Z3lRVTljalZaalVVMFI3WDRuNm91K0xxbVBOYVdhMElvVHRFUVhL?=
 =?utf-8?B?TTUvL0hzU0V4UU5pTUpxbXpHM05Fb0dISm1DeVd4bWVKTk9hcUlKT3hyV0ls?=
 =?utf-8?B?dFdKejlTRjlXeTBETXB6S0pQUFJFYTEvcVVTcExYSGlvQWpUTGlMbXhPNUxE?=
 =?utf-8?B?ZnQxT2U3SkQvMUVqdExzVjlIdHZ0ZnBiWGJkSzlKREhzdUVQejYwZVEramFm?=
 =?utf-8?Q?IQGGZIyg5fhv/SzVJOTQFzwgeKcG4vRGrs?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5894eb-3115-46a9-e46d-08db892ba1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:14:29.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvGTTZh2zeqFLSjl63MFUXUZYIkKMrMenCtPyRSSCeWMivC5+HeRLlFzQg38j03bjPEMVvYV9jmQNpT4SK59olPM07qMAz107HoJWG9SQMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7615
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
