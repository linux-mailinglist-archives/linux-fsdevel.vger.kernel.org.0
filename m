Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D093E6DB99D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Apr 2023 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDHIV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Apr 2023 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjDHIV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:21:26 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Apr 2023 01:21:24 PDT
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFDD52D;
        Sat,  8 Apr 2023 01:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680941112; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=O/H+fqIA7Krq86vj7uR4jdrbr46PbUs8B4NGr6QiQNcdV7UzY1qRTd9peqlft+jBr9M3UqplJIrxJXG7OdjWzXZq3zhUsHxGd7c4SSseKynqCzuPtYVJxa0CkrugZvlssuVeiaP3xz6yP7YMGhjo106b7kN848nLkC/QfypJuMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1680941112; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=f5GxR8o7Ggt9YMYg3PheCb0HLOvzlMaUU1Kp6RtnlAk=; 
        b=GE50ENM7hjP94iBW+OcDAzsUIe9XNvr2BMBMQqQ0k+emd7LoqUT2hGExu/lb9BPzh/AYFTU27LX9av16QNKxmoqw91LykE62JHt6dDTgLrY3Yelt+qrovATdqLQsPahQXWFuxEKwVVyS0ocJOFARpfZ17sIb4y4fAUAoPw535bY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1680941112;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=f5GxR8o7Ggt9YMYg3PheCb0HLOvzlMaUU1Kp6RtnlAk=;
        b=b+k4REHRckdplHkcD0+uH8xXZyfmIDNP7zMxXfgqh0uq9T4phrI+vTagLjxEOsoD
        gYoL8opnz0eEzRqLozQ9UUHyMUP3R3Jvx047+ljkPZadnAMWynUu7LhKpIA/B6cM/Z3
        VEYiKu2rq+rCna4tqob4NToychHoZG6QFC+lmeDM=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 168094110015246.65353275119105; Sat, 8 Apr 2023 13:35:00 +0530 (IST)
Date:   Sat, 08 Apr 2023 13:35:00 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "David Howells" <dhowells@redhat.com>
Cc:     "mauro carvalho chehab" <mchehab@kernel.org>,
        "randy dunlap" <rdunlap@infradead.org>,
        "jonathan corbet" <corbet@lwn.net>,
        "fabio m. de francesco" <fmdefrancesco@gmail.com>,
        "eric dumazet" <edumazet@google.com>,
        "christophe jaillet" <christophe.jaillet@wanadoo.fr>,
        "eric biggers" <ebiggers@kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1875fe5ac6b.80d0ee97297006.8007506286138600512@siddh.me>
In-Reply-To: <2438920.1673461220@warthog.procyon.org.uk>
References: <185a206e3b0.2e1071428037.6356107010427889199@siddh.me> <20230111161934.336743-1-code@siddh.me> <2433039.1673455048@warthog.procyon.org.uk> <2438920.1673461220@warthog.procyon.org.uk>
Subject: Re: [PATCH v4] kernel/watch_queue: NULL the dangling *pipe, and use
 it for clear check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 Jan 2023 23:50:20 +0530, David Howells wrote:
> Siddh Raman Pant code@siddh.me> wrote:
> 
> > All tests in tests/ pass except features/builtin_trusted, which
> > fails even without the patch. (Failure log: https://pastebin.com/SGgAbzXp)
> 
> Don't worry about that one.  That requires some kernel preparation.
> 
> David

Hello,

Please let me know if any changes are required.
Context: https://lore.kernel.org/all/20230111161934.336743-1-code@siddh.me/

Thanks,
Siddh
