Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E4177FB4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353397AbjHQPzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353408AbjHQPzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:55:12 -0400
X-Greylist: delayed 256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 08:54:44 PDT
Received: from mail-edgeKA27.fraunhofer.de (mail-edgeka27.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D709D3A9F
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1692287685; x=1723823685;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mld0t8jLrglldVeiZ2Tbpq22E3wqPyFgNAEyxSWHvP4=;
  b=JtlE6VEIo6ej3fw/VIHuD7pmm8wSdtekbQv+7XFMg5JFMVDgo7PKjayP
   XwNnff1BWvVuBn2P4dYHtbKhCkq3KCgnKVR3YpvwssgVbbLfex4uOhFdC
   kPeADSHWaeximvm7lOOA74yhhqe4COsbJYLNezOdbX8+fa8Cgur3Rt72e
   MEdp/noR/BFv/l4/EpyiNu1Zx6qXanje/hiePwNf8+PeD9PYm3Luj1vlE
   nXLuPWRo/8vTh53EWcFgMtz355Qe7A6F/EmjNSsvSsqIBsX8eIC879ihC
   sJuNm3r2TJ6ZLvBohNwBMs4AutaXDHNS0sdQ7OTw4j2cmZqOevtXnJ7tK
   g==;
Authentication-Results: mail-edgeKA27.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2F7BQDBP95k/xmnZsBaHgEBCxIMQIQCglKEUpEvLQOcT?=
 =?us-ascii?q?IJRA1YPAQEBAQEBAQEBBwEBRAQBAQMEhHUKAoZgJjgTAQIBAwEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEGAQEBAQEBBgYCgRmFLzkNg1aBCAEBAQEBAQEBAQEBAR0CNVABA?=
 =?us-ascii?q?QEBAgEjBAsBDQEBNwEPCxIGAgImAgIyFw4GDQEHAQGCeoIrAw4jrA96fzOBA?=
 =?us-ascii?q?YIJAQEGsB8YgSCBHgkJAYELLYNbhCYBiXqCT4E8D4J1PoRZg0aCZ4lrhUkHM?=
 =?us-ascii?q?oIri0wqgQgIXoFvPQINVAsLY4EVgSiBHwICEScTFAVFcRsDBwOBBBAvBwQyH?=
 =?us-ascii?q?QcGCRcYFyUGUQctJAkTFUAEgXiBUwqBBj8RDhGCTiICBzY4GUuCZgkVDDVQe?=
 =?us-ascii?q?BAuBBQYgRMESyUfFR43ERIZDQMIex0CESU8AwUDBDYKFQ0LIQVXA0gGTwsDA?=
 =?us-ascii?q?iEFAwMEMgQOAxkrHUACAQttPTUJCxtGAiegDoItHwKBDYE9OwWBF5Ing0ABr?=
 =?us-ascii?q?loHgjGBXaEIBg8EL4QBkyKSOIdmkESiUoFKcIMNAgQCBAUCDgiBeoF/Mz6DN?=
 =?us-ascii?q?lIZD44gg3SPe3Q7AgcBCgEBAwmCOYkPAQE?=
IronPort-PHdr: A9a23:0EhQExOsC1UUMhOyJ1Il6nZVDBdPi9zP1nM99M9+2PpHJ7649tH5P
 EWFuKs+xFScR4jf4uJJh63MvqTpSWEMsvPj+HxXfoZFShkFjssbhUonBsuEAlf8N/nkc2oxG
 8ERHEQw5Hy/PENJH9ykIlPIq2C07TkcFw+6MgxwJ+/vHZXVgdjy3Oe3qPixKwUdqiC6ZOFeJ
 Qm7/z7MvMsbipcwD6sq0RLGrz5pV7Z9wmV0KFSP2irt/sri2b9G3mFutug69slGA5W/Wp99Y
 KxTDD0gPG1w38DtuRTZZCek5nYXUTZz8FJCA13l4g/ac6nLkXL79elR3TaifsP9UKgmYguS3
 /9HdD/rqw0ZByFo/UyP0ZV72fE+wlqr8hhd/dfGbYKsGcZUda/dI9M5dzRGd/lQTDFMHdiCd
 q8DAcsFH+FgjtLi/GBU/DaFIjuQIu216BxYgyenx/Am9ekITC/K00sENMATu1n3ho3uZOQ8T
 r+8nbKZ/TScT6Jd3T3U1pLMKwsngqmHfuhxYIn942oSNQGVlHe1lZzjMiOJ+shRgkHDzrBRU
 /+G1WF+mj1SvDmQycZvlq3P25gvlGncpRcj54UxCvCIUxsoKc7hEYFXsTmdLZczWM45XmV07
 T4z0aZV0XbaVC0DyZBiyhLQZt+uKdfO7AjqSeCRJjl1njRpdeH3ixWz9B24w/bnHomv0VlMp
 zZYiNSEqH0X1hLS58TGAvtw90usw3COgijd8OhZJ0Azm6fBbZknx787jJ0ItkrfWCTxnS3L
X-Talos-CUID: 9a23:FrgHjG9RaQ1CNszLU3OVv0gEJ58OUm3T91v3Dm63IGNvTJSXSEDFrQ==
X-Talos-MUID: 9a23:m6ruvwbmCRVBBeBTqx/vmxRQC5pS2eeLFxlSscUA/OqDDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,180,1684792800"; 
   d="scan'208";a="57176797"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeKA27.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:47:13 +0200
IronPort-SDR: 64de4100_HJy+ElTTFwqn+AtTC7Wb1ZYs2HrpukQybOUpaAa6Rbx0biU
 9oIFFXsgcAwRjAMnYBgyAsTVgZy6hzyBe9VHzWQ==
X-IPAS-Result: =?us-ascii?q?A0B3CwDBP95k/3+zYZlaHgEBCxIMQAkcgwtSBz2BCitZh?=
 =?us-ascii?q?FGDTQEBhS2GPQGBdS0DOAGcE4JRA1YPAQMBAQEBAQcBAUQEAQGEfAoChl0CJ?=
 =?us-ascii?q?jgTAQIBAQIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQYEgQoThWgNhgQBAQEBA?=
 =?us-ascii?q?gESEQQLAQ0BARQjAQ8LEgYCAiYCAjIHEA4GDQEHAQEeglyCKwMOIwIBAaAiA?=
 =?us-ascii?q?YFAAoomen8zgQGCCQEBBgQEsBcYgSCBHgkJAYELLYNbhCYBiXqCT4E8D4J1P?=
 =?us-ascii?q?ogfgmeJa4VJBzKCK4tMKoEICF6Bbz0CDVQLC2OBFYEogR8CAhEnExQFRXEbA?=
 =?us-ascii?q?wcDgQQQLwcEMh0HBgkXGBclBlEHLSQJExVABIF4gVMKgQY/EQ4Rgk4iAgc2O?=
 =?us-ascii?q?BlLgmYJFQw1UHgQLgQUGIETBEslHxUeNxESGQ0DCHsdAhElPAMFAwQ2ChUNC?=
 =?us-ascii?q?yEFVwNIBk8LAwIhBQMDBDIEDgMZKx1AAgELbT01CQsbRgInoA6CLR8CgQ2BP?=
 =?us-ascii?q?TsFgReSJ4NAAa5aB4IxgV2hCAYPBC+EAZMikjiHZpBEolKBSnCDDQIEAgQFA?=
 =?us-ascii?q?g4BAQaBeiWBWTM+gzZPAxkPjiCDdI97QTM7AgcBCgEBAwmCOYkPAQE?=
IronPort-PHdr: A9a23:RJQI6B+z3smD/P9uWWy9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8WxzpGHSjo0ivZB5aysQf/qdI+1iKHJd/NcoAEARiez
 6RIYgHYl3YKGmZiqWqC2akSxKgOpDCf/g5ywLf5XKueOPogfoDvI9QzemtaQ8tODBJYJo+yT
 o8tCNIgZvkDlNOsimApnyeYC1OOJ/Pqkm5S22PQ0IRn/eguViXtzhErMvEk6G+E7/vqa65DS
 rGFzfbonD7HZdpowzOk847rKhsC+/CdHp5aUvfzyxk1NSb5nlOduZDJE2+k/7ws6Vmd8sM+W
 ruet005qj5+o3uz4sFxkLOXv5pF+Arj9iFW7bYucI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0P1J0L60SCLfKdepWO4hXtWfzXLTorzH5mebfqnx+p6gDg0ezzUMCozUxH5
 jRIiNjCt30BllTT58GLR+E7/xKJ1yyGygbT7e9JOwYzk6/aIIQm2bk+itwYtkGrIw==
IronPort-Data: A9a23:TlJ3yq1KWvDAi3xnwvbD5YV1kn2cJEfYwER7XKvMYLTBsI5bpzYFz
 WoWD2zQPfveYWXwLdEkPYi2pEwO6J/TmNJgTwI/3Hw8FHgiRegpqji6wuccGwvIc6UvmWo+t
 512huHodZxyFDmGzvuUGuCJhWFm0q2VTabLBufBOyRgLSdpUy5JZShLwobVuaY2x4Dga++xk
 Ymq+ZaHaAb6g2Qc3l88sspvljs/5JwehxtF5jTSVdgT1HfCmn8cCo4oJK3ZBxMUlaENQ4ZW7
 86apF2I1juxEyUFU7tJoZ6nGqE+eYM+CCDV4pZgtwhOtTAZzsA6+v5T2PPx8i67gR3R9zx64
 I0lWZBd1W7FM4WU8NnxXSW0HAlTPL9+qLbpZkGYqJeNxm2FV3bR+/hxWRRe0Y0woo6bAElV8
 OAAbj0dZRDFifi/3bS7TedhnIIvIaEHPqtG5yomnG6fVKl3B8mZHM0m5vcAtNs0rsVPFvbXa
 s5fdjdudw/oahxUN1xRBog3geGogXfyaXtUpTp5oIJuszKJklctiuaF3Nz9ef60GuVZvUqkq
 jjH5W/GAyM2adHC1m/Qmp6rrqqV9c/hY6oYDrSl8PNwqF6e3GoeDFsRT1TTifC9h163Xd5SM
 WQR+yonqak55UrtRd74NzWxu2KsvRMGXddUVeog52mlxqPS4gudLmkDQTNIctYhpIkwSCBC/
 laPk8noBBRsvaeTRHbb8a2bxRu3MDIJLGlEYSYZZQ8E5cTz5o0+kHrnVdFlH4a2g8fzFDW2x
 CqFxAAvh647g8RN3KK+lXjFhDKq4JbAVRI87AjRUkqq6wp4YMiuYInAwVvD9vdGI4axTVSbu
 nUA3c+E44gmFp2DvCOKR+oJEfei4PPtGD3VhlpyGLEu8DOi/3PldodViBl8I0NyO+4HdCXvb
 UuVvhlejLdKIXasca5xS4OqDNojyaXmCZLuUfW8RsRPeJ9ZZgKB/T8oYU+WwnCrl1Ij17w8U
 b+RaciEE3kXE+JkwSCwSuNb1qUkrgg6xGXOVdX4wg6h3L62enGYU/EGPUGIY+R/67mLyC3R8
 tBCJ46E0BlSTuD6SjfY/JRVLl0QK3U/Q5fspKRqmvWre1c9XTB+TqaOkPZ4IdMjgaETnaHG5
 HigXE9fxlflw3HKQemXVk1ehHrUdc8XhVo1JyUxO1av1XU5J4Gp6aYUbZwserc7sudkyJZJo
 zMtIq1s29wfG2SVyCdXdpTnso1peTKigA/EbWLvYyEyc9QkD0bF88PtNFmnviQfLDuFhe1nq
 Z2Z1yTfXcUiQSZmB53oc/6B9Q66kkUcv+NQZHH2BOdvVn/iy6VUDhDgr+QWJpgMICrTxzHB2
 AexBwwZlNb3oIQ00Yfog4aYo6eADtlOHkhTNDTe5rOYbCPf/nSRxLFRdOOyeRHcS2LG16Gwb
 spFz/zHEaMmnXQbl6FeArpU3aYFyN+3nIBjzyNgB2TtU1SnLphCM0u295BDmYMVz4AIpDbsf
 FyE/+drHImgOeTnIQY3HxUkZOHS7sMksGDewtptKXqr+RIt2qSMVHhTGBy+iCZ9Cr9RG6F9y
 McDvP8m0SCOuiAIAP2n0B8Nr3+tK0YeWZoJrpsZWY/nqjQ6w2F4PKDzNHXE34GtWf5tbG8ae
 iSZlYjTtYR6n0DiSUc+JVLJ/OhahKkNhix08U8/Fwy3veTB19AK30x30DUoTw5q4A1N/MBtN
 0NKaUBkB6W80A15pcpEXlGTHxNzOziEyErTy1c2yWrTFXusXW2QL18GGP2s+XoB+Dl2ZQlr/
 7C/yUfkXw31fcr34DAAZE59p9HnTv1z7gfnmv37L/+aHpI/XyXpspWuaUUMtRHjJ8E732/Dm
 sVH48dybvfdGRMLgqhmFbSf66sceCqEKENGX/tl2qEDRkPYWTOq3AmxO1KDQdxMK9PK4H2HJ
 ZRXfOwXbCuH1QGKsjw/LowPKeUtnPcWufwzSomyLmsC67aivj5ltazLzRfHhUgpfYRKsd08I
 YbvZT69AjSupX9LqVTs8uhAGESFOOchWiOt/dqb0uszE7A7jNpNamA3i7u9gGWUOlBo/jWSp
 wLyWJXVxO1Dl6VpsZPnSJtBIwCGOOLDavmB31G2geRvcOHgDMbqnCEWo2nBIA55E+YwWdN2t
 LLVq//x/hrPk4gXWlDjuauqNvd29+Tre8QPKePxDn1RvRXaaf/W+xFZplyJc81You1S9uyMZ
 lWeavLpUfU3Rt0E5nleSxYGIiYnE66tM5vR/3Ksnc+tVCoY/xfMdu681HnTampeSC8EFrv+B
 iLwuNes/tpol5tNNjBVG8BZB4JEH3G7VZsEb9HRsRyqPlusiH6GuZrgkkMu12iaQD3MWsP3+
 onMSRXCZQy/8vOAhs1Qt4tp+AYbFjBhiO03ZVgQ4MNylyv8NmMdMOABKt8TP/m4SMApOE3QP
 1khtFcfNBg=
IronPort-HdrOrdr: A9a23:b5jxSawjUJBTGE+pT1ajKrPwSb1zdoMgy1knxilNoH1uGPBw+P
 rBoB1273PJYUgqOU3I8OroUMK9qBXnmqKdzrN9AV7IZmnbUQWTXeJf0bc=
X-Talos-CUID: 9a23:BUz5q2yoi9azdctXrThGBgU5G9IdInTzi073OhSmAEYqbLCocVKPrfY=
X-Talos-MUID: 9a23:jIC4xQlG2l75k4F2LYO5dnphFvk3w6iNBHwBy5QcsPaFBwAtNmqC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,180,1684792800"; 
   d="scan'208";a="182263426"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:47:11 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 17 Aug 2023 17:47:11 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.171)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16 via Frontend Transport; Thu, 17 Aug 2023 17:47:11 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zkek4xMdXWRoJrSWW5TkqS/pa24iMUNybGq1cdlyx6tQuwND9gZoQOITxwlEvHFY119rbAnq/g8F9oWylnO1LIuLA63RgBvcQXKDQJWm4xd/Od/c4b5TPj4Sltbjh25I3SoKkNiaCjAvcTq535YlU4eC3xExImD05gSRzw1HL+v6tDY6kPdig+owvji+wANUwuHo3xbtZ/Y35sNAEX2n65Buq51xODI1gwnAnbjVQu1zMYqgbuFprdvC+WkwZPDGIgq+6fPv7ZYjncgdr1LpYFctIpDNnn1HqcagjrPmor2y/FizbCoAZQeC8yeTBBxD1PtsJd7oC5pylfyT2XGXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfvHEVRK1i+kDmwP+fcupzSWXX0DTHkKBvXw9eE031c=;
 b=S1bdr7MQC0aCB5t+TfgiuqCF7g6ukduX8/cRrybFpawldk9n112wTbJYF6tRVOsfkybTiMCjzV2KkxiBGjh3e/iVA/Ea05fzPhwxLQ8Ou8SgD8TO42VQOFBIkKp0d4zuV3vmhL2hPgtEOowR3MQHhlKAV6mZNQitBF/ruQWb9qazyX1HxoNvqnNIo3+htWMATqkDL2N5DjoVR2Zz+AwnNVHfQK3Op5IpKR9fNW27cq4iFRo5qksuMS+Jhgv+0N0yQaxU5qdcJfR9Wlh75KsGVuX5FJggabpZ3Slmqg0BuCIg6gTU36j0z3G9XpZUFIRSpivue+AkvbMg5bk/p9B5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfvHEVRK1i+kDmwP+fcupzSWXX0DTHkKBvXw9eE031c=;
 b=lJV1zekQETBcdh6hKZ6oAWisuew3VqLdfIlJoPI3w3S29ESOZTNf2JKxm09r5tNeA5Fdg/LCzucEKB0s8+Fw7a9s9Xi7H9clbAVrl1snK0cK2iy+DBKUJj8rJMTxnextDD4YA0I2YnuA6g1YTKviWgi+tLn5rR6Qp8Z2OklGEXs=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BEXP281MB0103.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 15:47:10 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::70d:507d:9c8f:cc3]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::70d:507d:9c8f:cc3%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:47:10 +0000
Message-ID: <8ce7f4da-b870-ac1c-5b35-0ca5b8c850d8@aisec.fraunhofer.de>
Date:   Thu, 17 Aug 2023 17:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
CC:     Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner>
From:   =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <20230815-feigling-kopfsache-56c2d31275bd@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BEXP281MB0103:EE_
X-MS-Office365-Filtering-Correlation-Id: b22b0182-4084-4f2b-0edf-08db9f3937b8
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXJo0h3BrzaoRstGmXiYbtPrYD/YJYkIYpINAhK+KSBayw5nSRJimQB5M2qci6lrDu3pvjSEjrw3/OgzHkAE0nc+aDOgKCh6lp/byaBDpg99qZM4/OaMeJ9Y1Cz6O1Tzod429BGtsr4/Pp4gItOXXUgbXVBr2/RpKjDG4TAcSLDVGVGclyzMLCVaWY3Wtxht/P0LhNFRC/Gf6UoKLuj/O8ZHW+DvO7TP+j7YVdGt2ta6ORT9Z896gHIpLZt+IHx/traXPmdfOg02/pzkBtgswQAM+cAF0ulqqHfKfEu0el20XbBLlF93fCtQ1UnngrZubEkE+TGX3PegUE73AEeX5OQ2BF6dY+9kBpq8smD1EaWu3ohHfIEqigbraG8vPWQKm3e+uVo04S3Qj5KxFuuTkX1SfKvhrKtFhRDuloodfwSEv+j2Zbvt5u5JyhyFW5I88mh1AZbsFVgrEMBaQZ/dBLZO7icaHhZ+GHhpKQYJzHtLT+L0+8f6ASTw/lV/+wdevIn9GaAWqLolxq/k48sCM4J9pT0xbBlVE0TqOpDZEsyd/VgsZ1bSVFw0EpvN23hCzrTuCkWtl8wyQa7Gk/1C2OBSETselQFaHfp9/MvVS01BGkTa8WKkQIU5RUCYwcZVFUA8E2FFM/gP/HV6IGTZElILWKCy02Rz6SWt8RO0RnYtx5bS01dkIdXnRe5cvCuflYhRteiNOyfLdjAEwD9LOGxigaCCnj2I9nb8ei5V/sI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199024)(1800799009)(186009)(66476007)(6916009)(316002)(66556008)(66946007)(54906003)(12101799020)(5660300002)(41300700001)(2906002)(31696002)(82960400001)(478600001)(4326008)(7416002)(31686004)(8936002)(86362001)(8676002)(38100700002)(53546011)(6666004)(6486002)(6506007)(83380400001)(6512007)(26005)(107886003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnRRcUZkNzhPK21NdGIwSTd4cmJMSXd3VE5taDZUaUFOZjJNVEdGQkpYb29p?=
 =?utf-8?B?Tms5MlVKL2pWN0tBUHk5eXkrVnAwK3pXMVFrZzdNMmd2Z1VMK0Z0L09PNENh?=
 =?utf-8?B?aXl4YTYwSFNTVlBESklaS2FXQk14cGVlMGRLS3BXOTFaZHBraXo4YStQVzVR?=
 =?utf-8?B?d083WC9KSkczQlJkUlZmZDNFdnloNysvQVhVZk5USytVWnc5V0duclIzWDQ3?=
 =?utf-8?B?VEtmWFY5VEZZLzkvVWlwTUhtUUdpZ0oyd2pwdUxPZ1I2V2wxdDlkTW1nMTVT?=
 =?utf-8?B?UlBtbGVuY3d3L1REN1FQMEFJR3V3VmtwLzVPNWtVTmZ4OXJVenRHc05rTmp1?=
 =?utf-8?B?TFd0MXk2RFFiNzRIVG5CcU9CTzVPdWQvLzJydlIwbDJLcFcvTFJtUkt5VlJV?=
 =?utf-8?B?bGMraDhhSDJlRVNEZVNDc1dpdHFuMUVhS09LTkxNam44THVCcFJ6UjZZczYw?=
 =?utf-8?B?aXB4SVN0VXJKdU1XeUxhdVlTYTdmZkJ1dkJ2SmxZbWRRVkR4TkxyMXlLK3E4?=
 =?utf-8?B?T0h2ZHozbERtYyt2YnFOZ2o0NlpuQlhhc2svZDlEUXhYUVhGT1pvQzd6YnVk?=
 =?utf-8?B?NG1kTjJsOUFEM0RZRXIrNWREbndCWWdrS1M4VnlsOHJWVE9Xelp2eFF3OFJ2?=
 =?utf-8?B?S3Vna0FzY3NzK1dMeG9TUHJsZi9DRzlMdHdXMDRlWUg4dVVRSnFMUFhSRjlt?=
 =?utf-8?B?eWRuakJoVU9ORGFnaDR4QWlUM2M3WjNrYUk1TGhxaTBnS1FhTFRScHhhZkNi?=
 =?utf-8?B?NTk0T1JlVG1XRFJSSGlSdGI2bm85VzJDbmc2cVRHK3p0NTVobzBwSVJ1bWZ6?=
 =?utf-8?B?S3FGTjRrYTE0RVc3cjFycklaMGNyVysrcjVKYTVHOUZoTnlGdmZidmo2S2hj?=
 =?utf-8?B?R0k2cDUvY0JvRkZUTHI1OXNCU0NJZnhKSS9SaVBPbFMzSHBOM2tpdzM5NmhD?=
 =?utf-8?B?elpzUkNEbHpaSVZ1bG9SNEFiWTRzZWNpaUdLcWFsbWs5SE52c1VRdnhoMVB4?=
 =?utf-8?B?RWRKRmdnbC9uVzRMdU9xTk85VytJcWwrUlFUc1VlZmkycE1XQWIwR1d6bExI?=
 =?utf-8?B?M1RkbnBlMXNzM1hxcmlvVTFab1dxRUhrbTQxZ0NSOWQweUtja2ZsQlZvdDZO?=
 =?utf-8?B?bjZxazVWWWhmbzUyb3lzbEc0R1pta3pUdkttRC9TMjNGa1BNQlFOa2JUSHhD?=
 =?utf-8?B?UFM2NU94WTQ5ajQ4V0lOMGFWV2luWGVrRDNSVkliR2x5TGoyS1J2dFZpTnY1?=
 =?utf-8?B?UUIybmtZYWFuTCsvaHYwalBDanh1b0FvM24rNGRuZ01tS01NazlranJ5QS8r?=
 =?utf-8?B?cHhkSzBQUWlQRnZYdXR5NlNiclQxUWdvK3F3bmc0M0N6ME1yRFJMMUhDS2dD?=
 =?utf-8?B?cmtEZHdmbUtIUzhHd3F3NnRwSWQ4YVRQTThoTUFlQ01LY0FtUUNzczVidlpl?=
 =?utf-8?B?UzM1TkRqQk11VlVWUGZ1RldkSUx6V285VmkzUm51ZmxRSFp1M1RiblJYK21o?=
 =?utf-8?B?QzB1Z0UyNlErNGV4UzAwWmN3NU1Mb3ptUTFyRCtmaVR3clQxK1BNdndxRUJi?=
 =?utf-8?B?SFdEN3JzYit4aVZaalVKa3ZJeU01Q2hwbHM4NzVJU2hOaXRqV0dHdVpPR0Yv?=
 =?utf-8?B?amZQWStOU25ERGtnNjN1RkZQRTVqMlZqKzEwZGtib0EzUW45NUNJNjFOUE9z?=
 =?utf-8?B?NHY3S25Pd3FZbDJtTkhBWlZUVUZtR1FlL09DUVRRMTRGa2JzZ1NGeGVFVFFx?=
 =?utf-8?B?M2R3bTk4L2FFUDdRQWFsU1BKTVgrNmN6K2pQTHp3NjYzR3lndlVNd3BYVklL?=
 =?utf-8?B?YlFhSnhEcUxuWVZHalF5QlZ6bkZBYXNKOTRZanlUVHI3S0o0RGlRRU1KUUJN?=
 =?utf-8?B?YkkrL1VwWjNvQ0R6Y0k2WktuQ25lU3p6QTl0N09XTjFFOHRnZkNBYlB0YmVv?=
 =?utf-8?B?QnU4eUZicDVpZ215WHpJZHdqb1Nod2grdEZNV2RSVWJoT2pzMVpWeGpxUW5z?=
 =?utf-8?B?aXIxQkN2aS9OS2xkUzVpaHN0UWd3MFl6K0QrZHF1Ri9XQ0hJcU14NTU1Rm90?=
 =?utf-8?B?WEZmMmF4WTVYREtGRzFiY0hHUkdBdEJpenRqeTNRSm8xOFdPV3NQdC80ekJt?=
 =?utf-8?B?QXJSSzdoRVRlUDcwS3VQQVovbGUwalovOTdmQmdPbEJ3K3VtSjh1cHUyQ1g4?=
 =?utf-8?Q?XLek87feNVrg5PLMFQP1X9E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b22b0182-4084-4f2b-0edf-08db9f3937b8
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:47:10.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yGFK+92QXI3bQxaujNyNOKmhFGcuKRzozKKgOOj5GyeB8ePfBK55Flen7BJhGbMRLAn+M7TPpI5zu9D/bHpBrcMjCCg9b+Zn1IDDOlCjUljxJF01e/9jRRPs8tk8zs0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEXP281MB0103
X-OriginatorOrg: aisec.fraunhofer.de
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.08.23 10:59, Christian Brauner wrote:
> On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Weiß wrote:
>> Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
>> which allows to set a cgroup device program to be a device guard.
> 
> Currently we block access to devices unconditionally in may_open_dev().
> Anything that's mounted by an unprivileged containers will get
> SB_I_NODEV set in s_i_flags.
> 
> Then we currently mediate device access in:
> 
> * inode_permission()
>   -> devcgroup_inode_permission()
> * vfs_mknod()
>   -> devcgroup_inode_mknod()
> * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block devices and friends
>   -> devcgroup_check_permission()
> * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info afaict
>   -> devcgroup_check_permission()
> 
> All your new flag does is to bypass that SB_I_NODEV check afaict and let
> it proceed to the devcgroup_*() checks for the vfs layer.

Yes. In an early version, I had the check in super.c to avoid setting the
SB_I_NODEV on mount. I thought it would be a less invasive change to do both
checks in one source file. But from an architecture point of view it would be
better that we do it there. Should we?

> 
> But I don't get the semantics yet.
> Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs or
> is that a flag on random bpf programs? It looks like it would be the
> latter but design-wise I would expect this to be a property of the
> device program itself.

Yes it's a flag on the bpf program which could be set during BPF_PROG_LOAD.
This was straight forward to be implemented similarly to the BPF_F_XDP_*
flags.

Cheers,
Michael
