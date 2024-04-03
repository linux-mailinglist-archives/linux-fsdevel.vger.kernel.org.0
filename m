Return-Path: <linux-fsdevel+bounces-15999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973318968D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5A71C20A06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951796024A;
	Wed,  3 Apr 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ciih9+Gp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC705C61A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133338; cv=none; b=Ju8GuM9QW0RR53/YwMaa1fqMGA5ArBRhdsd6vg+iNzLf0r8jD6BGLusvSrxBDDAssqOq3Lb4UCegM5lFRjnq4SgtyMJ9ZUz2nNCf8CnHuYHvV+jmXVqd78ZFwZtzw0ECw8k8mcdXPiViy5cgwQB7xWxbkbKX9Gt03DVKljXVhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133338; c=relaxed/simple;
	bh=OmSFh5VdA8JBtffIKSKqr3t6zAyb8rR95Zwlzv4Z+2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mYokVngEIQSxz48f7J+2JkSpCf81AFd38/3251Oiab3dChh5pAN1tBLuKFfEjcJwALrOsAxqDEejW0h2C/6S42OxDdfEBUZiruak5nyoUWGnA7nGIOUc3VFxTKDokpvs62VchuWSUyYRTlg+l+7lN5fGrtTZXR/p9mQzivSFr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ciih9+Gp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712133335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o5EWBbXw6HhqIxph/6E6u2gCPJ/TAx8zCkleu1dQeOo=;
	b=Ciih9+Gp+JFbnG012hZOgqVjFCH2ii6Ym10zQMdxKasB/LvW4NPtAYojOvaMP3zrsyYOnf
	bLVsr11Go37q1+53jeMSKa20ZKpbQv/hB6n91a3UWz7/KeWt8i+RmaAY7PZnQhpl9CXZpv
	mx2phksjqoKgLl8RCY5J7fD6aDnU5Dw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-ja4Rwcf0N8-lMT61BCxpCg-1; Wed, 03 Apr 2024 04:35:33 -0400
X-MC-Unique: ja4Rwcf0N8-lMT61BCxpCg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-516b06774bcso2267476e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 01:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133332; x=1712738132;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5EWBbXw6HhqIxph/6E6u2gCPJ/TAx8zCkleu1dQeOo=;
        b=e10c+OBidrh6dNepElkn7NfwQgs6yuUW/e/NLK41mTTaeCghB0aASf4wvQwAPtW2Cd
         EI2TxTVxtOu7ecDn0vlcWaFByjj9rRpawzfbOxZiW2PMM/KNu96DQAjURD8Irts5c3Dy
         LJCAFT5vLFiCuLt3HFd1UHafD7mxkOguk31IxUJmc0pNlI1vRRdbYPtEO1vjQHZQrTdU
         nOI7Yuf9nMeuWyBNJOAGtOmU1vEfPMaADr9NjPPCHPWItnl1sDgWOax+JL8KFQi4U3qq
         FY2V7gHYV6uuywVuODU5fXbb+LCjjLgtmZr0yM+eDeK1pS7sDxnRDWnD1fvL4ifxzerx
         aQCw==
X-Forwarded-Encrypted: i=1; AJvYcCX85HebbQozMY/FXnaVBjfmjCFEj5QyiqmSmd6qXPhB84Z7L9+23uoKOPkzSwcFYUiRjbVoNoCjhw6cbzCCJVOAJu2Vx7qums/T8aG34A==
X-Gm-Message-State: AOJu0YzlWEbnsgEu14cFgs7FqHk1CKqLhX1CcyrsJ0d6QDoW6YoVKwF1
	Fho+TabF/9/GHADoAq9p6VTemLLbdrqhkLc7FgwJSC0g51OIQ9giMqry2j1X6lo061wooRj/5XN
	37iJvmduNTRf8wNz23k9KEirQCDkGpkx1eEP1z8HgpIKQEze4FM6timi6jHOSWG8=
X-Received: by 2002:a05:6512:3b9d:b0:515:d16b:5ce5 with SMTP id g29-20020a0565123b9d00b00515d16b5ce5mr12483945lfv.7.1712133332224;
        Wed, 03 Apr 2024 01:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG9P4HdLdtvxj3Ce/20jeT4plZ5SS3QziVws73e0CrV1AqWUTnvb6MkTLUw8t6bZWmlyGv0Q==
X-Received: by 2002:a05:6512:3b9d:b0:515:d16b:5ce5 with SMTP id g29-20020a0565123b9d00b00515d16b5ce5mr12483926lfv.7.1712133331802;
        Wed, 03 Apr 2024 01:35:31 -0700 (PDT)
Received: from [172.31.0.10] (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id g17-20020a19ee11000000b00513d021afd1sm1964715lfb.103.2024.04.03.01.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:35:31 -0700 (PDT)
Message-ID: <fffa121a156d92b907136774c41bd83c43e859ca.camel@redhat.com>
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the
 fsverity metadata is damaged
From: Alexander Larsson <alexl@redhat.com>
To: Colin Walters <walters@verbum.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Andrey Albershteyn
 <aalbersh@redhat.com>,  xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Date: Wed, 03 Apr 2024 10:35:30 +0200
In-Reply-To: <992e84c7-66f5-42d2-a042-9a850891b705@app.fastmail.com>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
	 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
	 <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>
	 <20240402225216.GW6414@frogsfrogsfrogs>
	 <992e84c7-66f5-42d2-a042-9a850891b705@app.fastmail.com>
Autocrypt: addr=alexl@redhat.com; prefer-encrypt=mutual; keydata=mQGiBEP1jxURBACW8O2adxbdh0uG6EMoqk+oAkzYXBKdnhRubyHHYuj+QL6b3pP9N2bD3AGUyaaXiaTlHMzn7g6HAxPFXpI5jMfAASbgbI3U/PAQS3h4bifp1YRoM8UmE1ziq9RthVPL6oA8dxHI2lZrC/28Kym7uX/pvZMjrzcLnk2fSchB7QIWAwCg2GESCY5o4GUbnp/KyIs6WsjupRMD/i2hSnH6MrjDPQZgqJa8d22p5TuwIxXiShnTNTy5Ey/MlKsPk6AOjUAlFbqy9tw1g2r1nlHj0noM+27TkihShMrDWDJLzRexz8s/wB9S2oIGCPw6tzfYnEkpyRWNUWr1wg2Qb+4JhEP8qHKD6YDpZudZhDwS+UXGyCrbVsfp3dZWA/9Q7lSIBjPqfTnFpPdxz7hGAFHnPQP0ufcgyluvbR68ZnTK6ooPgTeArEZO2ryF8bFm31PPHbkBCoJ5VLQGupY9xFBmCjxPLJESx1+m2HB9+zED3LM0zjJ7ViJcyK02wLeSlzXt7LWFYOZVklJ6Ox6vVKNXczS0CXqZAA1cPxZlIrQkQWxleGFuZGVyIExhcnNzb24gPGFsZXhsQHJlZGhhdC5jb20+iGQEExECACQFAkP1jxUCGwMFCQPCZwAGCwkIBwMCAxUCAwMWAgECHgECF4AACgkQmI0nkN8TYr5UngCgwrKNejiglHH181N5HW2VHgtlpMAAn046j6Muu6gnykJqmaAesuq6vfYfmQGiBEgx0csRBAD6YYAG+iA0eAnNbw0CQ/WtSpV7i8NLKxSTpr0ooEAgUfWHCTP4xxY2KQDECEgVsveq2T0TcycgSK/1W/n7mI13NN++6S4Btz2qH5Bf29CqF2CBxUrmC3LWITcMyFxtdpzKInWgyQDfOWopgnKQQBaMJW7NKHF5DYhaC9UNMDbPu
 wCgoGbE1bvBh9Tg6KMWlBK+PsHFkC8D/RX+IA0ldyvw2G/jXnqK4gDHD c3Ab/Nofxzc1NTKoAxEsqWHRfxptyxA+rVZ4jVJHEHw5LOTojGjUqrUiqoFDcw3htp0V6zsUEYmaDTVZfVBf5K62BD2h58vH6O0oK8UYWn0NomHQ/t1urL+qFG1Nf/wI29ExFRkYORZXLQau1faBADf4Q9g6DRT/CfWMcbsGJcAN7uaB6xlQXenlc4INPo5KF4XTxWV+UbxK2OzxHHEBA9EQ2mDj0WuqWII100pd6fIF8rmpc+gvIcxKDCbgQ/I1Wr59It/QMIZcK2xF/p4V05QWKtXDE2AbKlab1T7WSfGewACI84LSF/qATZRm9xWu7QkQWxleGFuZGVyIExhcnNzb24gPGFsZXhsQHJlZGhhdC5jb20+iGAEExECACAFAkgx0csCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRDrYhbdt2xw6djpAJ42jsKMjBplAxRg9IPQVHt7iMhzEQCfV4TG/nT1x+WnfKAuLNZnFbrrg+u5Ag0ESDHRyxAIAKn2usr3eOALd9FQodwFTNeRcTUIA+OPOO5HCwWLiuSoL1ttgrgOVlUbDrJU8+1w+y3cnJafysDonTv1u0lPdCEarxxafRLTQ6AsQgCdAkaIFXidQvLRVds9J7Gm787XhFEOqKcRfKtnELVjOpPZxPDZwDgwlUnDCNv7J8yb39oac2vcFiJDl/07XdCcEsk/E1gnZUKwqVDPjfNoTC6RSZqOEnbrij4WV+ZAP+nNA1+u5TkfWYRpgHPbY6FU1V+hESmC364JI+0x/+PB3VXov/dMgzpwrbIzXD7vMg186LVi+5tiVseY3ABpCXFulIgi10oYTLG7kNQXkry5/CcoZc8AAwUIAJ4KyLrUTsouUQ5GpmFbm/6QstHxxOow5hmfVSRjDHQ/og9G1m6q5cE/IOdKSPcW226PYFXadGDQ7
 dgT02yCQmr4cmIeoYPKIUeczK6olJwxLT/fw+CHabFa0Zi9WOwHlDrxZz c0bTAS6sB9JU/cu690q9D8KEnlze3MARihAgN6vrFUBTbOy1wGQdv+Rx3kNMjHSeWYqHh/cmzbun46dYI4veCsHXW2dsD1dD/Dw8ZNVey5O6/39aS8JWF9aL47iI5Kd9btFD88dNjV6SDXH5Gg5XIHWMU1T1EwTtjahuinZhagbjRYefoKzHRGbDucVHWGzwK+ErUoYoijx+xytueISQQYEQIACQUCSDHRywIbDAAKCRDrYhbdt2xw6b8EAJ48WXrgflR7UcbbyHma4g5uXSqswwCeKuxnZjkxOkPckOybOLt/m1VtsVOZAQ0EVhJRwQEIALnSxFUPLjQDSYX8vzvuA+mM/YZW6dD5UZ3k1jQw/CVLEbZPEzRXB8CMdm8NxbEpXTzjZtV8BdbOZvEyJVFkoUkwCyNaimy68UKDXiHjKwElgvRPiCZpM6fj13xZSnInM3Ux5LwYQ5W81Rr7D+r5Jxbz9wgJ6vOQxKKJDODzo+HRhO+mwXL995I9mTlV9jbw3DnbTgM7rPTr6Lge4ebvC7y5I+7dM2tDBI+CoX4J5jWcefD8tkhjp1HKSRY6w6d/I9J3QQrxBgkPqrqLUk5y1e60b+BHga9umuANqC0lClCYcdoaeh7Sokc4PRM537uYSJ6XQB/I8zCTNyhuLkvB/CMAEQEAAbQqTmlnaHRseSBhcHAgYXV0b2J1aWxkZXIgPGFsZXhsQHJlZGhhdC5jb20+iQE3BBMBCAAhBQJWElHBAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEGp8XUSCFw49WqIIAJ4PrvKli4GP5/HVN+bdv3NbsTeDYUjWAtwrUpi9rz2kTUhSZiIVvouT+laA1mmxtyGxfF3tw6HfWnrrPVH8zPXRdg7n/ffPiWuwlidrbSKy3sZ/ez5/xaCDfVPbwN2FE/sgP
 yaOxkmjaJO61pYTAAAPbeCCwR5bWTMywiI6rNsn5ZcaFC/aR19c4uANIkS VofeBex3rSxuDElUMPshjGgidu/oL9Zdz36stxjvOtq4AhGgOswhvlncQTtInkg2EHcD2gzR9Uh8aj0zW02ST8Uhupid7TtGZv7i+gDbDJPXAEeyrPkb4XGQU7X6ADItzcBQdIdUVfuJB3nHiz3XD4nm5AQ0EVhJRwQEIALYQ3XuqExEQNFVjv+PqqPcKZAH/05M21Z7EmKalD+rrRrcusTQoC7XR45X4h5RFBzHYJHEdIhfeQACk5K7TG5839+WpYt8Tf2IvClzCenh+wRimGWvDlqCQVTOR7HYnH77cuWni/cVegzUWaCjwbMDMqWTQkWqzNB/YUDnC6kWHSFze7RzCWfdbgiW5ca94ChoXVZlOyM/AnxC2y2l3rzzTVlv2Md7P7waQGTloWTG865kW9cZHA7Kjk7xHKMUURpGqLpYQE0ZhyayKGBKDd82LWG09jXwCpRxpmsFpJDfpEwLu09tBlAauDjSFaU+sxa/McM866yZRgfzGwAeN258AEQEAAYkBHwQYAQgACQUCVhJRwQIbDAAKCRBqfF1EghcOPayOB/4pyF4zhAkJWGfFyy/eB5TIZFqC6zAgOpZzrG/pJypMuA4FKVpVyqtu1USslcg3Frl9vd5ftSa4JXJI+Q+iKnUgEfTv7O8q06Wo5gh0V32hoCqZHFfiImI2v/vRzsaLT3GDwRZjsEouiwuiMiez8drBnuQs7etE8aMRXSghq8fyOJoAebqunp3lrAZpk/pzv5m4H6gUhlPvVGwWg08eFEoh3hwLjN1wrVULMl6npV6Sl6kKaaHbrhMl2t9rRMQ4DG3gNNArPSAJggqDxBGljD9RGL+Q/XleT8VucbyFzay9367uYJ3cUS+G5/bm3ssGZTGwBYJH0dGB2eQVp8A1prYkmQENBFYg/CYBCADWh19QL5eoGfOzc67xdc1NY
 cg5SvM7efggKhADJXu/PKe4g5/wDX/8Q/G2s8FKo3t527Ahx/8BlPR/cCek yAAYYknTLvZIUAGQvnZLDKgOmrnsadKrmhhyIWGxyZe8/aqV9GaaD2nzXzMLoxE48ucy3tK8VELR4ipibb7YvmjWG7zoK7yH51Am2u76/7TX1yV19ofjN6hr2SpmjSU5hL6RcRkSY+/Rwr+63IpwEnNmIlWXRe2R8nfB8b5uHhXte9Mb3IJQ+lm758bYZUNX4nCZCWPHjhqc0VlO6tuDc6G3abYWbld2LXys3ZgTU6aBqAtQz59U0zrGqmk0ACcuXhw7ABEBAAG0Jk5pZ2h0bHkgbG9jYWwgYnVpbGQgPGFsZXhsQHJlZGhhdC5jb20+iQE3BBMBCAAhBQJWIPwmAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEAyxtrVWaIWGMQcH+wS62GiJ3zz7ck8RJCc9uhcsYreZjrGZF0Yf0e4IQUuSMxKID7KGUcIRiPROwF2/vgzSO3HJ/WcIALlEqURgVGxp08MXJExowDAUS6Tu6RRdt/bUNYwufu86ZcbSTii/9X3DlxYc/tBSP7T7dnNux+UtyQ2LLH6SQoEs7NkCj0E07ThWbWYPZikvwEZ5gTZSDdRs0hiv/F1YnwqSIeijPBtIqXx035/GF+5D6kopUEHheDi1MSj5ZnFR/YaVl6Z78arnqXVLo9P4RZl6ys4Y1o7PDdUVjgB9VNpoSpkganfSPj5HNXRfiwPpUucEIveKWpyH4f5fgwcMYfzBX6KSRLO5AQ0EViD8JgEIAOZQcfDTJWDybC/B6GHLBojvlOmjzweoQce6NNuda02PPv9gvogHnS1RegKio0ynozpmgn0w8UjSTqbO3PgvlYGxau+TOktXwzAAEVLyLu8SZyPOim+qHU5+4vUJPnlS4WPVv8SuMsWexdVMsfSch9slG8c/lPcMYvPAwuBngDrHyoKEDgLwEM+8E
 uHgyH9eKtT/To/rnLTXFdPKjGGB/3FAgf7p7nv82g65X+VEibIWg+IQWGZQe TYjYhSF6+dgunmbLDOm7SjSNBtD4bxUpYpwPGP1QN6stbvr5DquaNxHmYa/b2kegvoEfLUshZMqRoQCFCfpAUqGF97y0aAHz2UAEQEAAYkBHwQYAQgACQUCViD8JgIbDAAKCRAMsba1VmiFhn52B/0an3HE0FTS9fwHMABISOmdowCIFQ8T0V+5EAHJRCSubZARiU34CIQ80E25zCnkQDJ/wXnodnLKsR+NMVy36BbufUnlSq5HNRo8ZCQuSl3ROjs1IgRb0XDjKiqTQGmbqshyON0af3inFIms6Hvfmk64AnuPVfwvAAWdM93XF3QkothbN5MxxKe9xcuFecFEnwplhSCEq3LZhe1Ks3sorvTM7n/KxW+gAlDzP4Et31hInUAbRBaw6KoxCLPK3HeDBlV1/zZ8hhUpefNpd4pkL7lGaePBsMPz0QD1AkqVDRmvx9hdRnZ8qJu2tQSrq9d9xS+c3abOCxIxLoxyyMIg3jFG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-02 at 20:10 -0400, Colin Walters wrote:
> [cc alexl@, retained quotes for context]
>=20
> On Tue, Apr 2, 2024, at 6:52 PM, Darrick J. Wong wrote:
> > On Tue, Apr 02, 2024 at 04:00:06PM -0400, Colin Walters wrote:
> > >=20
> > >=20
> > > On Fri, Mar 29, 2024, at 8:43 PM, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >=20
> > > > There are more things that one can do with an open file
> > > > descriptor on
> > > > XFS -- query extended attributes, scan for metadata damage,
> > > > repair
> > > > metadata, etc.=C2=A0 None of this is possible if the fsverity
> > > > metadata are
> > > > damaged, because that prevents the file from being opened.
> > > >=20
> > > > Ignore a selective set of error codes that we know
> > > > fsverity_file_open to
> > > > return if the verity descriptor is nonsense.
> > > >=20
> > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > > > =C2=A0fs/iomap/buffered-io.c |=C2=A0=C2=A0=C2=A0 8 ++++++++
> > > > =C2=A0fs/xfs/xfs_file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 19 ++++++++++++++++++-
> > > > =C2=A02 files changed, 26 insertions(+), 1 deletion(-)
> > > >=20
> > > >=20
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index 9f9d929dfeebc..e68a15b72dbdd 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -487,6 +487,14 @@ static loff_t iomap_readpage_iter(const
> > > > struct=20
> > > > iomap_iter *iter,
> > > > =C2=A0	size_t poff, plen;
> > > > =C2=A0	sector_t sector;
> > > >=20
> > > > +	/*
> > > > +	 * If this verity file hasn't been activated, fail
> > > > read attempts.=C2=A0 This
> > > > +	 * can happen if the calling filesystem allows files
> > > > to be opened even
> > > > +	 * with damaged verity metadata.
> > > > +	 */
> > > > +	if (IS_VERITY(iter->inode) && !fsverity_active(iter-
> > > > >inode))
> > > > +		return -EIO;
> > > > +
> > > > =C2=A0	if (iomap->type =3D=3D IOMAP_INLINE)
> > > > =C2=A0		return iomap_read_inline_data(iter, folio);
> > > >=20
> > > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > > index c0b3e8146b753..36034eaefbf55 100644
> > > > --- a/fs/xfs/xfs_file.c
> > > > +++ b/fs/xfs/xfs_file.c
> > > > @@ -1431,8 +1431,25 @@ xfs_file_open(
> > > > =C2=A0			FMODE_DIO_PARALLEL_WRITE |
> > > > FMODE_CAN_ODIRECT;
> > > >=20
> > > > =C2=A0	error =3D fsverity_file_open(inode, file);
> > > > -	if (error)
> > > > +	switch (error) {
> > > > +	case -EFBIG:
> > > > +	case -EINVAL:
> > > > +	case -EMSGSIZE:
> > > > +	case -EFSCORRUPTED:
> > > > +		/*
> > > > +		 * Be selective about which fsverity errors we
> > > > propagate to
> > > > +		 * userspace; we still want to be able to open
> > > > this file even
> > > > +		 * if reads don't work.=C2=A0 Someone might want to
> > > > perform an
> > > > +		 * online repair.
> > > > +		 */
> > > > +		if (has_capability_noaudit(current,
> > > > CAP_SYS_ADMIN))
> > > > +			break;
> > >=20
> > > As I understand it, fsverity (and dm-verity) are desirable in
> > > high-safety and integrity requirement cases where the goal is for
> > > the
> > > system to "fail closed" if errors in general are detected;
> > > anything
> > > that would have the system be in an ill-defined state.
> >=20
> > Is "open() fails if verity metadata are trashed" a hard
> > requirement?
>=20
> I can't say authoritatively, but I do want to ensure we've dug into
> the semantics here, and I agree with Eric that it would make the most
> sense to have this be consistent across filesystems.

In terms of userspace I think this semantic change is fine. Even if the
metadata is broken we will still not see any non-validated data. It's
as if we didn't try to use the broken fsverity metadata until it needed
to be used. I agree with others though that having the same behavior
across all filesystems would make sense. Also, it might be useful
information that the filesystem has an error, so maybe we should log
the swallowed errors.

For kernel use, in overlayfs when using verity_mode=3Drequire, we do use
open() (in ovl_validate_verity) to trigger the initialization of
fsverity_info . However I took a look at this code, and it seems to
properly handle (i.e. fail) the case where IS_VERITY(inode) is true but
there is no fsverity_info after open.

Similarly, IMA (in ima_get_verity_digest) relies on the digest loaded
from the header. But it also seems to handle this case correctly.

> > Reads will still fail due to (iomap) readahead returning EIO for a
> > file
> > that is IS_VERITY() && !fsverity_active().=C2=A0 This is (afaict) the
> > state
> > you end up with when the fsverity open fails.=C2=A0 ext4/f2fs don't do
> > that,
> > but they also don't have online fsck so once a file's dead it's
> > dead.
>=20
> OK, right.=C2=A0 Allowing an open() but having read() fail seems like it
> doesn't weaken things too much in reality.=C2=A0 I think what makes me
> uncomfortable is the error-swallowing; but yes, in theory we should
> get the same or similar error on a subsequent read().

If anything the explicit error list seems a bit fragile to me. What if
the underlying fs reported some new error when reading the metadata,
should we then suddenly fail here when we didn't before?=C2=A0

>=20
--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a lonely alcoholic firefighter looking for a cure to the poison=20
coursing through his veins. She's a tortured insomniac Hell's Angel on=20
the trail of a serial killer. They fight crime!=20


