Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54A911D4A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 18:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfLLR5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 12:57:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34060 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLR5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:57:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so2390463lfc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtt9q6QTWhtx+uAQaSa9SaxP9utyh4MwkS3b1QBorDM=;
        b=OOXv31QnIKHP+WN0REsqiLUpZrI6yxWjWJ/GvuSup3OYLi1us4yUSocn6DI/axDV0m
         6GK7jXK+6k7LpPebQoPCRcocvjkW9omBDzxT+Lm4LYfIKGy7sKkeu15HX8MNjs/xu+xP
         KjLl5e+iu8ZQnjJY5qMbfJqikj0qvnk6CZ3uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtt9q6QTWhtx+uAQaSa9SaxP9utyh4MwkS3b1QBorDM=;
        b=Wu/+vG5BFCsXpy3VPu01nWPuES3IaFIzGsJhIZFG+tUWcBXEO3lqVOSZdEeBYukuML
         N8Ij1S+K0q+IZ8bqoiK0PrQkyiwqtDT/XUCHsjkU2PMIdc5fsoBS0UE8c2j9zbJnStaH
         rVQ3GxeEvbUtnV/XzDTe2z9itxXs55VTk8Yi6UIW74oZ56XPAjCN2ZDSL31Se9KWJb9s
         H60H2lU2R/a5f7u5eEGq+If57FE8hWBxj4W5fsnjPq+1hpi8IbHrpHXFaR4V0BSkySCT
         LDpmvkEXQ0xEJMAM+mFfXQ/B5HEvvW9m6g3pOKksBC+HTF+MHsJJmX2DYdqrO4E0aDGh
         ZrSw==
X-Gm-Message-State: APjAAAWhUe4NZONhGbooLoT2SfI9Km83B6GEx5HDwvPfWmGb+nykPKU7
        Hkm+TO2kaPoKwIB5trIvi78FuwDJ5Ys=
X-Google-Smtp-Source: APXvYqzneXAodlyukY6LB/D9OAt7yXeXRjHRaqhNpXpLaDiqJfyt8zqal1Kc3R52PkAgppG08kOHLg==
X-Received: by 2002:a19:ac43:: with SMTP id r3mr6630868lfc.156.1576173417320;
        Thu, 12 Dec 2019 09:56:57 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e21sm3736515lfc.63.2019.12.12.09.56.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:56:56 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id e28so3260756ljo.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 09:56:56 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr6857860ljj.1.1576173415852;
 Thu, 12 Dec 2019 09:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20191212145042.12694-1-labbott@redhat.com> <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com>
In-Reply-To: <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 09:56:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
Message-ID: <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     Laura Abbott <labbott@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008e989005998578dc"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000008e989005998578dc
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 12, 2019 at 9:47 AM Laura Abbott <labbott@redhat.com> wrote:
>
> Good point, I think I missed how that code flow worked for printing
> out the error. I debated putting in a dummy parse_param but I
> figured that squashfs wouldn't be the only fs that didn't take
> arguments (it's in the minority but certainly not the only one).

I think printing out the error part is actually fine - it would act as
a warning for invalid parameters like this.

So I think a dummy parse_param that prints out a warning is likely the
right thing to do.

Something like the attached, perhaps? Totally untested.

               Linus

--0000000000008e989005998578dc
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k430y16a0>
X-Attachment-Id: f_k430y16a0

IGZzL3NxdWFzaGZzL3N1cGVyLmMgfCA5ICsrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL3NxdWFzaGZzL3N1cGVyLmMgYi9mcy9zcXVhc2hm
cy9zdXBlci5jCmluZGV4IDBjYzRjZWVjMDU2Mi4uZmJkMWUwNWIzOWFhIDEwMDY0NAotLS0gYS9m
cy9zcXVhc2hmcy9zdXBlci5jCisrKyBiL2ZzL3NxdWFzaGZzL3N1cGVyLmMKQEAgLTM1NSw5ICsz
NTUsMTggQEAgc3RhdGljIGludCBzcXVhc2hmc19yZWNvbmZpZ3VyZShzdHJ1Y3QgZnNfY29udGV4
dCAqZmMpCiAJcmV0dXJuIDA7CiB9CiAKKy8qIFByaW50IHRoZSB3YXJuaW5nLCBidXQgaWdub3Jl
IGl0IGFzIGFuIGVycm9yICovCitzdGF0aWMgaW50IHNxdWFzaGZzX3BhcnNlX3BhcmFtKHN0cnVj
dCBmc19jb250ZXh0ICpmYywgc3RydWN0IGZzX3BhcmFtZXRlciAqcGFyYW0pCit7CisJaW52YWxm
KGZjLCAiJXM6IFVua25vd24gcGFyYW1ldGVyICclcyciLAorCQlmYy0+ZnNfdHlwZS0+bmFtZSwg
cGFyYW0tPmtleSk7CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZnNfY29u
dGV4dF9vcGVyYXRpb25zIHNxdWFzaGZzX2NvbnRleHRfb3BzID0gewogCS5nZXRfdHJlZQk9IHNx
dWFzaGZzX2dldF90cmVlLAogCS5yZWNvbmZpZ3VyZQk9IHNxdWFzaGZzX3JlY29uZmlndXJlLAor
CS5wYXJzZV9wYXJhbQk9IHNxdWFzaGZzX3BhcnNlX3BhcmFtLAogfTsKIAogc3RhdGljIGludCBz
cXVhc2hmc19pbml0X2ZzX2NvbnRleHQoc3RydWN0IGZzX2NvbnRleHQgKmZjKQo=
--0000000000008e989005998578dc--
