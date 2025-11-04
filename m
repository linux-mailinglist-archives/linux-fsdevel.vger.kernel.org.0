Return-Path: <linux-fsdevel+bounces-66987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D934C32F47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B76346088E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8D11D9A54;
	Tue,  4 Nov 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hgmMXZ4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC512EB84A;
	Tue,  4 Nov 2025 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289159; cv=none; b=BrZpQ9xDijNyiL+TmGEHy+IBVao4rh61XrHj9ndzUHwu32dJBpH6CBMXcGt6ZvAr2COVQryihwEJBZ1gKZqZ6ZlPWNOG24fKkEL+fGtfWKLybQ9EEA2QpoCKrAhT553d4QUQ6zkPVzJ+fboWDqhDlHKA/pTkf+PfAc8fESbpY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289159; c=relaxed/simple;
	bh=l6dgkwVTX+nYYUEUarUe9Z8EG8LznFvBnfy7Dit+dJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+poQSL5M+HNci05Ggj0//Zij/hQB2SU+w7sOekbVFFXctfCYLt+a1mAfahpq+oN34zdZjbL7bSBSmLTG2ISRUWSOHJbANn6z0fQXy6xHbD5XceFYg1gjTcXhuXUuiyd6yD7kiD29OPsmyizqQlOHKoxECqjIaOGudsoNPvdy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hgmMXZ4G; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762289155; x=1762893955; i=w_armin@gmx.de;
	bh=0P/Z+v6CnKjg6IgFnYEQ2dxLZv6jFsLO3430lUKgxhA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hgmMXZ4GJ7VDdxVSBTh+WZ4S1v0pKNZ2B2NaCkIYuu3027aqmdONDaYOkX8US0B9
	 VnmGVIJkBK4FvHIu9aZO6DQogkfwBEYc3NCX3fs3l2ACfYFwToipIDgh7vRIkl/do
	 jtay5eboLjwNNrpcsQpLkL1ng+UFa2+69vbr4AIlrolO8T20lIv55BOeDgtXULkMy
	 JuR7LdMaocKZxkzCzf5NZcP5kRn+434/XCBVlryKVTJxFhVSMIf1ECtT5Gp49WtQU
	 2ow3kithQ7e7XXpcR97wYhGVcqOv4auoF/541goCt4vd1eyDNmpeyUyivF5U+NrqS
	 v4I9mEj43Ik8/l/9Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MVeMG-1vhmAY2X3s-00Qiro; Tue, 04 Nov 2025 21:45:54 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: wmi: Use correct type when populating ACPI objects
Date: Tue,  4 Nov 2025 21:45:38 +0100
Message-Id: <20251104204540.13931-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104204540.13931-1-W_Armin@gmx.de>
References: <20251104204540.13931-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:riXcmsvGPwJnij0HYgQlb3vy/fbUqdIVtPjkNwAHGGKPD7uJ729
 hV88vx/gd4QKEUEtUFeWd4dmsn9i/8kTdiaHQGs4ZEDEGQo9b0kwMz9anq6/fVMCM9FcWGw
 xPBXjle/lTyza478zVTDu/hlwqmtuzzz/MAItnT8/9KWkTbklRWqRBdIE6R+Qz4gWnU7qS2
 tjcdQ5WRjeg+zVV5GN/5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fDLqh6eH6dc=;0Osm1V+KFuENB3d5R9EVGaiTXvZ
 hlDv0PglA2V+M2VPdgsmbm7hlhKvgOzkW7Po6rllB4sw7XzWFAoGoOZaMYxMvE2qulv8ORBkg
 T8mFsRSPcEx/i+TvOjfMPqvN+it0uUpgiPNxPW/e0Eg8fOeRdtWMvPxVYPvtmpnLTsxPdnnek
 ytVc1E8dWxp0byh84gxdeS8P0eVRiqImrwlYaO/86jJ1DNXkMyTJ7pICr9NkAcYT/wPJBYMZw
 ifmO45TF2kyLwN12RTR7InZ5rSvm2s1qu2EGTRar23YR9fitYQWMh7uBML64Vsu/WAKsXCivL
 wqoCQX8chjKXKkOP1PF1fKKMJq+EudPxlYQVg4sudl9/354I4eukaI/gyp8RIi7aG6H4RRqsc
 StRAW6/MOc3JvrAtNrljl05kQJAadMZpm/jXFOYE+j0RpzC/+eG4QeQvMmfryZ/Q9c3G++b09
 jVxPGDfImdFKu5AE6VirKeriixQ5mMzmKOJSQ3YG1vd9eeQlMpxX8zpsA0NdDM9crK6WLLgZg
 2FCV/W7LWERAdrTaazAQUNjvGQ9h1D4m60lIvGjL8EA829Yn3PJp7+qFCWfVChCOT8w+aBarg
 a4UBC4vGcT0MJSA6oBd9Ln4U+jXEmFE0/5dPQXVCPoHDArPkAuEHEL8AGgx25ujmKxVUDipEH
 9W2BZ6mwROEFbGzFRAPJfjO0H7igeELB9uNPHYc/t8c7dXrrlVTNY0uJ7jvBS2YCpYDl9/Hni
 R7UvudJn8OAPKQ17rKarnaA6jgL8oygdZbbWXPAlcd4stPuO5DjzK/nqrz829Q0gtEpoFiH6c
 ZF2anlqt3+6dA+GowxhPfbRELz6jy+4e5lSmjRg2Le9mi78m9uidXX1qWFMs/H66dUHTBA0BS
 N6kfa9PAogIdquHyfZ+qzvlGp0a5vX8/oV6bkSyVsSl8p4VZGbsmdU7rh9+o+47bkE+eRnhxO
 1AC7K+B2dHwjmSM8j5f379/YQkN2rxGAty7xa6f0Z+SauuR44ypEGwXPjjjtVVgF8CTLm6023
 s1zhU/I2me6LCCdvgW0VvMnmp4hn254RN3+ACKbkE5Y8Hc4+SrOI0JzoGXdwREiSR9IZrR9+p
 TBOjoh05mobxcmvs6CKRqe7ggdsDKaggB2Bv5UIi4AWCX6T5ZRFYIxLP87qJOh4MBI+lA5VJp
 V9SvxBxAavmwpD4OPdS79mug7zCaHnZRUNxaoQJIAMRVBFSLFLs+h5Fo4jB/wPQSOIBcj60Kg
 wZW1X3SlbdWSCd57otytIzOFfm56Q6JMbHjCWz6YT+96F9MjjzgaW1wYotCjeWpzcWlUXiErx
 CzCY/8vqOVKQ+ejn4CUED6GOT+xZLFhSOhUSb9tTwXL1GVmrZN5aGKsRgwHxZZp3mbNSsKmgS
 JscMMhNt2Du/3yds9HRYP8mY89Ij0wYZYQshBLyr9nLcVVZxwo1Jkk8d+RyHUGKVGw227jBV/
 +xicOCPPsfiMHDJObiaKJDd9M8CNKvtorWRjJ9bXwIjiWrlmu2AuqzpBVpFPoD0zqZAQPhD0h
 PVzq6T3jI1ESVwJ4tofIh3+0ScgQrrGyYGGUopPbP9K2EhSf0JiGAToxXsQyc+zDkgwQdMjBi
 hKW0a53r/NHxIqdB6ZwCRti+7I/Sfy4uKFtUVx7t4B3R29COXE7bMJp12NZSdNW/WPfxHa1O7
 LcrR8rrLcyzJbS8AKJPcbiYJuJ3j+QOQgxTPVQdIzgqNfNJLLz+PSWbVD/+ljcspTq1owKUPI
 JsH+8qou437e16MH+VZ3YVj3F+vOF3a0cmxyYpKwaiCStgZAF14XSSdRE7ZKNXlteCoth7+iY
 SV4e6dQad8AK9F1ytoZeRvt8IwCfmxZCKLJnXpUgGpaKSGn4f/W4MB4xWARIYH/ppr5WTdUca
 EIOoSgW6aaMyWPY2leB2OgZAgd2/t+XeQ82BGrGy3xdv6cYTy/0kYnr5dyfA+Eo6FeILcqAp0
 7XgSG2adRGJ0YrSVx7ieE+jsqXtrZewvxtlriqH1YiXnA0FB6KazL+dfe0oyyt0K3XnJOlE6u
 oBLeT96eYNRBJgnYu1KRRKilgcAS1kAbapAyJcTjS02bQzTlzp5HYcqJND3vM71PoZ90DPq7Q
 iANBHbePye9E+W7urkTjRMzpj8fpsN3csWFEZKEzqAof18NMCrc9ohNZBeP8UICr4kkJ4zbaX
 HprIrqgz9e8uOnZHj8pR0R0fIUwZnzOKu7wyhEHuBDKUdO4LWxiwtzTayNC55gqD4Fg9uGmtJ
 hPePWht/6uSBxHEYBLKIEKe77nkazbe8rd6TsChiPb27RTf+POXqr1Dn/ocR99N4Q/JpP9lrd
 j71ZWW5vBMoPAnrARj1WiOnCfTuccaDY1cPMxhWV9zADY1GM7owq/duINdmDxQIIAzTvQdIxo
 uTwWdFBvCbOOWWsehNrb+qrtnJLRrS0+4oPp1kP6lJY0Kx30qzHQN1j3zPRp/krWePpKYSEQJ
 XMX0UVQjx/CJxcEY8kbU656VlFkdyrAooNOAOA0em7J+RN/QKuOpEacldao9C70eIiJK6fSYh
 Z9uXaRk/m3OMGF0GPlM8h7CBgs1H1ruIPyv2vJ5GOJ12xxP2wLJduPqjN1YKsF4BCg4eASoo3
 2tRUM6Z3pky/L6t0kgThD5ZF5alonDawxe9VbnSckGmUvsnAgKTG3xiDx16UibZzZdu8hIj38
 2qR4ZCizk8SxUzb5PgtvBNZIDPrRmYpikyhFzt/bHBddyF3Xqj9o5yJ4npgGA/yGL7Yr+zNjg
 f0EV8elPDM9Urgbx54Zpg/HEjlle5HVFPSFAjNkjNyPGc7rbj5GSGZ4rk6pbNRrVHkg+N2EnO
 KoOvgkeBODWcsH68G36aZsVvwKImYKHbzKNI6ZYGu/a0HqMsehg0plhVEdvvn1Ln41joHkOn1
 Wc04MHIVaDpcTrmtgksszYN59jjF0y08numds4DF+vYrmkkM3bAJ/93gkSbuALsem7Cd6r6QF
 BLSILxdD01GJ5N4BZvmrWOPMUelInZGoowUxmLR6ufEJas55F6MbC9UrIM/SZnCG9hbIrvakP
 sad6OYKVt3RPUbhmaQYpEa+Uz0O+pGye9p0K9EVNONVgim60qM0z3Yhf9jCbQaBxallWfdf2y
 VKYmmK4kYZUHKMTOkMFO4H/bo9n6vXgjEgGpelZGHC1S1WjPEHm+h+9Oef5DVmB9HH6ws34GQ
 MW6/oWfyL8RUjNgpT7R0PUNZPHwoAZEPJ934C/yVyWVD29AfFag8j7XjOmzS9412BdD6n4YxE
 2IRinuaAiCK5dLmAth4BASS1nR8+CUrYxDMWqoAzE6uFkVUoBhyiW4kfrOQ9h3kcvJD431LKx
 b7jE4l/Rxy3fr4ihTAyhmXJSpdBcVGeURsB30TdN7C39fjfq/oh0F4Tdly02w9y/pl1387CKQ
 qMTF+g5K1dOizTydUnh1k9l1Q/Pwp83h89eyrstWgxh9O/qHwG+LphJtwbdok6VxJyv06oxFj
 PdrBtTL8dgkzeaePOJd2oY1n9yUp1gelVKTp4/U5jpgPfOAMPHboiQpkl7RcCdv3BCtH1xRPi
 IwkH2d9w6GU8cxXvUkrDSG174UcoSFdcbjFLMKcYD2XOUWSZBVz0YEO5Fu6dqBUrGjkDTwqEc
 EV4nYWFbukDJE6EXQwume1qyTgF6tMiW5AvL/+HGIWWVAjcUL9J2r4PMtbuYzCZb+QZUfZxHG
 txGU95tfdklIXi0ROoJ1zg1VBoYI3/GhB0P1BF283hIc2toGKccAqUrZq4UkaTxWU+1QApff8
 +NdrM+xnFUuuAas+VU1szNE/7tBfeaF9VRKAPiVeFACTyICeA7BnYIFIWmZ6kk30QK3oSMKqQ
 t2U2tiGEyzberH7M8DQoO8BGIsBMzbpGmEQEQRT0rJ3EExJC0iHuldm+q44evgTaCO2KJE+ha
 hGhJYUm2HyeF9wzBghLeEVwP38DWdN0ORru03/2MswX2zUPS+BNpyykEnhKWm5RPzzHW3/3dW
 MtJ9l5a6MuHAegYIEU4cAVVmZKegoXu0GvuV04RU4772XraB3zdKVPmI2QEJsOsNavudQ1Oxj
 3U8ZDX6V+NSDqK7SWMmY3YU7xy4pXjAAhcyVXmSiXaEktQ9E2S0ciac/6fphwJhm7mRTAecZG
 ogtSRLeqmyP4ZspJ/BGI/YNcSJBVLj22Q2Nyg/dDlF6SP4gPwxQzqpKinyalUXz7CYyuLu5iY
 q8UH0hb+od4Sx1vXuFUX09tHCTx1YNXtSi4pEK6bGfgrjEXRnFZRGzlghQGUhe6RSjphZ8ubO
 gEKHiXP7tlEiHIALXQ6MOgoCe4kIqUHkV7DT0dxNA7Vf1YqTUNXKKpdbFbMfpiyW/mm7a8Mkc
 vJj+Nd9C9s12nnPXddw1vIWAWexfey9jOg4146b2gD8AFpNviDRotYXOF2P3YbFmutcS27sF0
 jbU+ufMx5Ru0xGwEfdJVT0/V7y/zKqjTvPB7tIfjpvik952/dYT4hU4L02ne/0Mnn+uqvwRVY
 Km0FDYfy4/yRfnYeSqI/xoh3J9Rm3W0OlP92xvqQHvi808NiOCwP+dG+uJn4ClGoXOcsbXjh6
 bpP+DlbC9LAoxvzrYiFsBxMP+OclwDbUuNvhuE8J8VKExd1p/pjrqXDglXAm2b5qmetfgWbF9
 zDETrJCYX1El55ST4wx26+cDwotJHo11NoVfy26qWlIEiz8M6xC7cvTpQhvm/FdchI3RR48Rk
 4w8NxFKAvXFJncc16Er5VpuufGyjMDY7HSjjeYacQBJAvRTMjrnrSWFAw1+QuYJCK/eKDRsX3
 lbI+RUYPlyk0eGFl8VgvIHgQiZlcFT/8/WWCA9JhIB95w1J+kGtApCdgOBNekn3fwmv0n0IvQ
 H4t7G/mE0ntBcYGI06SdnGTAFJQLCOgH6F2VCWxq0iFHrTEUIcZfFZy6SdmEvdhZxKBCcpFg1
 1epBBYGQyDwoCqsQ3pjJw9RSWi5YYreVIQTA1N5bO5a67rTPDo2Nh7Cq7+wv+/yyydsFaqfKC
 79NiSCzs8z90ocaezV9oCAPUB5SCeXnHD35EBzhICseCt0enyOAXCjCilxEhQ+YQW4BiLHwy2
 n6IVHCZlg2SIjNNpNftocja2K1yyHAQ1UsZc3Nl0lYdhvKFOSMsV0q+GMuDidJWNTSLs5eDY4
 ndnyFmGsXp+UPdDzuZObgiW3MmMOQDRhkdf0W5

When evaluating a WMxx/WSxx ACPI control method, the data buffer
either needs to be passed as an ACPI buffer or as an ACPI string.
Use the correct type (buffer/string) when populating the associated
ACPI object.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4e86a422f05f..6878c4fcb0b5 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -142,14 +142,6 @@ static inline void get_acpi_method_name(const struct =
wmi_block *wblock,
 	buffer[4] =3D '\0';
 }
=20
-static inline acpi_object_type get_param_acpi_type(const struct wmi_block=
 *wblock)
-{
-	if (wblock->gblock.flags & ACPI_WMI_STRING)
-		return ACPI_TYPE_STRING;
-	else
-		return ACPI_TYPE_BUFFER;
-}
-
 static int wmidev_match_guid(struct device *dev, const void *data)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
@@ -351,9 +343,16 @@ acpi_status wmidev_evaluate_method(struct wmi_device =
*wdev, u8 instance, u32 met
 	params[0].integer.value =3D instance;
 	params[1].type =3D ACPI_TYPE_INTEGER;
 	params[1].integer.value =3D method_id;
-	params[2].type =3D get_param_acpi_type(wblock);
-	params[2].buffer.length =3D in->length;
-	params[2].buffer.pointer =3D in->pointer;
+
+	if (wblock->gblock.flags & ACPI_WMI_STRING) {
+		params[2].type =3D ACPI_TYPE_STRING;
+		params[2].string.length =3D in->length;
+		params[2].string.pointer =3D in->pointer;
+	} else {
+		params[2].type =3D ACPI_TYPE_BUFFER;
+		params[2].buffer.length =3D in->length;
+		params[2].buffer.pointer =3D in->pointer;
+	}
=20
 	get_acpi_method_name(wblock, 'M', method);
=20
@@ -519,9 +518,16 @@ acpi_status wmidev_block_set(struct wmi_device *wdev,=
 u8 instance, const struct
 	input.pointer =3D params;
 	params[0].type =3D ACPI_TYPE_INTEGER;
 	params[0].integer.value =3D instance;
-	params[1].type =3D get_param_acpi_type(wblock);
-	params[1].buffer.length =3D in->length;
-	params[1].buffer.pointer =3D in->pointer;
+
+	if (wblock->gblock.flags & ACPI_WMI_STRING) {
+		params[1].type =3D ACPI_TYPE_STRING;
+		params[1].string.length =3D in->length;
+		params[1].string.pointer =3D in->pointer;
+	} else {
+		params[1].type =3D ACPI_TYPE_BUFFER;
+		params[1].buffer.length =3D in->length;
+		params[1].buffer.pointer =3D in->pointer;
+	}
=20
 	get_acpi_method_name(wblock, 'S', method);
=20
=2D-=20
2.39.5


