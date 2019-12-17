Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B52122597
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 08:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfLQHgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 02:36:47 -0500
Received: from mout.web.de ([212.227.15.4]:55115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfLQHgr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576568192;
        bh=MkFauk4FbBi8F1H60mEp/N70BcROkpOlXjn/w3ORveM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lHZb14vuAhczzo/hLhJ7oLP2D0ds52Tnc/MMHllL9r2QhpsiTnfH9qZwIqiK0tAId
         x8neUK6IsNopepBGS8B+prG8Yu2gNhs8L28flgoHpZyroxtj/Nn1xAD4fY8lnMp6V8
         sUQ0DGVbaaVx9t+j+tNRgHWL5d8ThSWIDviRz9F4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.185.133]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZRnx-1iOlZS3RGP-00LEhk; Tue, 17
 Dec 2019 08:36:31 +0100
Subject: Re: [PATCH v7 01/13] exfat: add in-memory and on-disk structures and
 headers
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
 <CGME20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e@epcas5p3.samsung.com>
 <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de>
 <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a428a92f-d54d-9648-371b-55112874be12@web.de>
Date:   Tue, 17 Dec 2019 08:36:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rp7twKgeCUfVFU4+zn2gQzpvw1YvUps61vWRJiPMoeSf/Ka5hnc
 e+eOfCzWXFBgRVfgmsZQF+I3LHCl3vcHEkTwyO0iVfwQ4ulCjB1PChl/roJSJt5bBetz1yx
 Un8CMfv38guQgIIcJ6LMt47k7513RXgEQnJjYPwKPiqTghQMeBY/XBO8pejVfqyAnuhmOhf
 leQJVdXRXWHZOlAJP7T3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jcSrCpKjy8E=:ppliMEZB7JuxcHvFmCofMG
 xRUS9U/4km0ZtBKu4OTMTCT69ZAdBtLHBfTEWn8AaoTPFtMYjCbcNqr2PS1UNG2OGG6XyrLuJ
 FgT5aV+pHN0VPQGN1AA685N2EO0aWEgtDivk7n7LKhmpkwAWyWiQbbzzwVGjE96+4xE6z7uyX
 iItoswcI7LYXpi44wTw3TXD3yFSZKBxXJX+xuMpm41vlIGCeshMhHNt43eGDoIgFTP2Z+tqhm
 46fFvJZRhRY9+uj04bW4/DkUPUCTc767SKaKsTgtmZw5zvMg2316iKmZq+uh0C448b5pQzvXW
 Ya7tIGy9lluCdTDUET3Tgo75x3ibkqH36sfzrwTUwjY6FvKgYLC92yZ18TuYClBRZjEr6UBV9
 Vt+1G2ayAoNY3LOYWolbTwrR7NfINXYogGyRUjGjXsGT8VWK72K2t/NOGRiEShvF82o9a1+ih
 hz6h1xSygYaSfhWsIdSIbzYFzOaUOTKJ6+w12KwU1kK6fd2gdFqnzKxajTk+WpOjq0/Z9n4cM
 vLPV/fhTQVFUExZxGQEjbO7gZWLPsacaPwLq0ayfo80Q/qKZeRuadHE+16B8kfDSCy5puGGo9
 a/YADgPnq3k5QsQ65qmT1yebxfDX3HxTZPTL7bDHHXZJQjYfEoPheD+sPZ7RspxLKVOdZ3niQ
 d0/oV8GqGKvYFzt8bF2bJmrPK0u6T6sV3OKNqvJ5rbcQnYyIIKOBlm28SToQuS9zIeJvZiQci
 yRcMUatnzrP6F58/uZQoFyi7h8+TSMJ5cktjxjp5HWzOpQwdgrBIHfJflwZHhiUS9G58Dzuia
 73n/OhrLkpGZ/+ERgDZYiGcNROHXy5A6qxNFY7X/EvFQbPqTiQA1tZo9n75k5ZqUEaPZIM4yc
 el8HNCWFwEHQvqjshrAUo7VV6fJoV94k8mDXH3KTgwIx04rWyTqKkzjRRnuN2OL7Nuxrb/YQ6
 foGLNnDviV3K7Tj2hsv050u6Pk5YohoJp8T1cIudumRylKfhoBIjQppJhxVInzIJox6hzMNqR
 dpemKcSeVNOwk48i5jJGjzM3RS+O5etP+Fye7aEVUELzjltXDAFa0MWLVVki3bVXVXm7/cIOu
 mC0oP0ZwlKcKGUPtMztBZsTmaimcmAfCQjD6ANdU/oUojuUQb+EXyt1/usIoIsNk/mw68CLPT
 O6FX4liAFMVCNgqHViVmNf94IgzhjACP87nn3cb+2Qkj5nVre6sqgPJaYPelCTMe7ddsCu6Mx
 qpoBLuj2/drVFgc+qqVq/cknROsYgmTbe57DTrBqyU2BzBa2Dvn3mHbSu2Ok=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Good catch, I will move it on next version.

The declaration for a function like =E2=80=9Cexfat_count_dir_entries=E2=80=
=9D can eventually
be moved instead if you would like to provide a corresponding implementati=
on
by the update step =E2=80=9C[PATCH v7 04/13] exfat: add directory operatio=
ns=E2=80=9D so far.
Is there a need to recheck the function grouping once more?

Regards,
Markus
