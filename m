Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA56C2EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbfJAIbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 04:31:33 -0400
Received: from mout.web.de ([212.227.15.14]:34595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732738AbfJAIbd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569918655;
        bh=uEaNgF8/W7jxLx+nK9u6Zze2gr1PDsS2bf27/yBG1Sc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NfQaBzr27iw1hVAN6LWU3e6seLXMxrYMdxx06XrpDMycIIhUWNCiJ5jEzJrUhpvhm
         gNTpbSgFnO4VxW7DZ+w5LVEqjsGUP0KcSJigjfzASy5W28g+EA3z917lkx46GD37lg
         11x29/moBUKCKp+mruHl6JDjIFy3kAit4+rwIM74=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.188.160]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWinD-1ichZk0Ckd-00XsqN; Tue, 01
 Oct 2019 10:30:55 +0200
Subject: Re: [PATCH v2] fs: affs: fix a memory leak in affs_remount
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        David Sterba <dsterba@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de>
 <20190930210114.6557-1-navid.emamdoost@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <44ad775e-3b6f-4cbc-ba6f-455ff7191c58@web.de>
Date:   Tue, 1 Oct 2019 10:30:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930210114.6557-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wgp6OF25pMnaIJ2HzGdp+iMn7T62koCOIPUQQ4mgspfLpattIdf
 dvBhg34g/CCTYonReyj/vUPr5QsTGHAr28Qhv7YJpWfKiSGsUjK5/xO/kUdWD0nhPdelg4u
 qfSLVdKUKtRKqvzrnC+w9oYuq/tp3l9/+5idWhiATI6GVjPvHONY/3dyM761BZ+tmY2OHRT
 25lEorDZWe5JgAWHdjNag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i5REQtY1IqM=:+y3FNtSz9fF2Qbte4Q5YF/
 sp9mEllSZbzqjDCht7CkpWkWA8cGTeb6IHxHIXMzV9LocEMcgjEzhoAdwT14CfIfhsP8wb5Nd
 4p/7bB4DvATP2yBQYE5xEX7Po4m5S24dKZKcHHfTBEAGdLJ0MeA8+vqeQtOk1HVH1V+sSehNY
 o5yIBbRzu2PnzxlQV/4Zyvyh1AVwSXhoYx71yCCjrap10yNtGtcpspVdsxmTEjZk8wk4Hsany
 xqRzJO8jJL/lw+j1ry6fWxHobfaehEuu/yVu8vJmphypV0ZR5HtmltqUg2vslRDjNshoOLQY+
 1rl7lfyR+CsYlCiQE+rDiA4jKw/JEg5EiuxKdv8BWxIKOjFrRQT7XzIfkRWNnUeLHqiyAovmL
 i4BCPRQTC2EB0sJNCTMp2w7vNMwFsiI9IdjixWPZ0y21Ay1hcxJ8juR580QsSYuDOZfRLUSXi
 D9n2ozQTDPGwK09vFbfUI8EQG76IOVJnFrTa86FriMcpQ+a3W+H0I5fFbXD6HDpDhWc/BAhU3
 cDuuTXS0C9Fsn2fEjISal/Oy+7aXf+MOcp+ipkzdL9+s2RAVOIh6q5OyjHXQur5Ys2R6py/aj
 gq0hbLv1HFhIM6gWkjlHKcvkuvhK76DXD6xJ1QVVZ/HwA8JfMLGVP7l5ArtC6LNzDKb/qH/M8
 iWKESgv9a2CQnwKlUd1zXLlNYtq/ZOuQExqFngxXYfcUVgrT411nUZKUpIwQXp01qkK7D5l+E
 fgVvLC0viUQ2Mn/aZ0LzPlp/QiVAqv52/zFGFmGWhIHyi75w3V1Jw1vX5aHwTrxUawkzP098w
 t1YdgVvKpScTciG4wPyPmCnRelISjj46XZrbvBsVazCfuLDTzbLZnSkiQALCf2UhkD6zqnH0x
 3W6p1jQC4S4fw52FGBkW35maGYYWSqnOWMLrRcrgZQbLzwfDtjo5kI34jACsSdIQYfjdXrXvi
 fLwrpLOeO1yGsNEz+pBKpHJfZAnANKKcHfun6gDJC/quZ0YY8iUZvhOM33lZH0DX8p9afZMu1
 7wcaAt8wPGrxafsYMucL8k5PG7pihlP9PmJHLCBU5oqbrll+ujU7SgHP42EbyVAPhRrDAOiz7
 tcYgJNR4sb/ChR5yBlq6GFUfuINxLE6B4ejhCf4EbhD9vAIaz0LKJS80BkwI/+XEm382HKSEU
 QH4CLHkS69uNp/R5LIhgQ8Y4JHks72Olk0zrk4zB9OqibOAUOXOzWAiEEH1apfkrKhZ9DC856
 LU6vNinBik0leBYN/pn+mve4nl2TeGu8iO8O3DsY8Bbm+MBgjvEJ30dbCsS0=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The allocated memory for new_opts is only released if pare_options fail.

Can the following wording be nicer?

  The allocated memory for the buffer =E2=80=9Cnew_opts=E2=80=9D will be r=
eleased
  only if a call of the function =E2=80=9Cparse_options=E2=80=9D failed.


> The release for new_opts is added.

* How do you think about the change possibility to delete questionable
  source code here?

* Would you like to complete the data processing for corresponding options
  any more?


> 	-- fix a type in title, =E2=80=A6

Please avoid typos also in your version comments.


> ---

I suggest to replace this second delimiter by a blank line.

Regards,
Markus
