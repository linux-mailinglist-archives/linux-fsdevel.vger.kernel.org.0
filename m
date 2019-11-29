Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBA10D73C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfK2Ony (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 09:43:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35374 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726808AbfK2Onx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575038632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07R5CcsCDb5ZnoHBMkFPcMeVPYNSPLdNY/EmaEEXPCE=;
        b=dkyReNt8b0FA2v+jbtoRucO8HykC099VDd7XcG1gT6he3DPASBIfp6QVecJNuYZ6jAeo13
        34nIkSttRO7vvscB1szyenplKmmNiDUyFfauU9AIHozKH8vLM8Bdrg1MW2HKDam97x5Zur
        0OpPcDRxOga8fTtI3n9XSnLm+j/2uXQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-8uWvMkDUNt6OHzIc-6lT9g-1; Fri, 29 Nov 2019 09:43:51 -0500
Received: by mail-il1-f197.google.com with SMTP id t19so246028ila.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2019 06:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcxCZ1T6ObDD/o3DydMlzCp2J8NjBn+/A1S2bJY4dt0=;
        b=cxZSreAdnJ3BRlALkJ39Cffl9hDbBm5p0qi57QG9sKO+D4RuWqnDOZJkq3L1/xQBfW
         FdY3e/wHz0nXI4J+4oDcoZu+RQFF2W0rYjT7bGAeApnpOClgGj7XdCrqcrOp2SgflzTF
         0Mi6s1b6lGrbfzFdUU6oXgSYxeAfGtwAyQV+eWiEZSvUeN4neB72zNUvYY2O8Ou1iAty
         MK6JIYKiqlpu2/bJebwy76BRQ/xYRSTloykVaJ5mUxICbLWmMZxa7LZ0YXBjseNcHoT2
         l2QX5sAnaceNR8kER0tZwPDi9mt8ZryY6Ha/vHxnnvQ8C+TNEIvtTr5qK3hxoC/syDE7
         Gdug==
X-Gm-Message-State: APjAAAXqAlY0ejuFmJ0YMi8QUx3w5xPzys5m7NoEabAgVgkiDuqGAd9E
        titQ7oFDlRSfSwnbAXYolBr/Dp5JDdH/Z9/kUDMHhgH5qMe1ClpJqaeWKjrxZuioNA/tFwzuh9J
        +KurfU8UMMZJqb9dYjAwK4il6o9GXvlCFTQKAb9L+zw==
X-Received: by 2002:a92:c50c:: with SMTP id r12mr57822937ilg.255.1575038631024;
        Fri, 29 Nov 2019 06:43:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBFGDa0xCe3lBviMI2n113cbZEg1EuEFb6kDHPyE0hDZL3+urbRr8OYAR+dvLz2owFoc/D4GdLqdlz/1iMGKs=
X-Received: by 2002:a92:c50c:: with SMTP id r12mr57822918ilg.255.1575038630861;
 Fri, 29 Nov 2019 06:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com> <20191128155940.17530-3-mszeredi@redhat.com>
 <8694f75f-e947-d369-6be3-b08287c381e9@redhat.com>
In-Reply-To: <8694f75f-e947-d369-6be3-b08287c381e9@redhat.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 29 Nov 2019 15:43:39 +0100
Message-ID: <CAOssrKccHtfwg4SYbQRwoaz_WcWJWNM3JXk7BHv=SPpsKOdkuQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] fs_parse: fix fs_param_v_optional handling
To:     Andrew Price <anprice@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        stable <stable@vger.kernel.org>
X-MC-Unique: 8uWvMkDUNt6OHzIc-6lT9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 29, 2019 at 12:31 PM Andrew Price <anprice@redhat.com> wrote:
>
> On 28/11/2019 15:59, Miklos Szeredi wrote:
> > String options always have parameters, hence the check for optional
> > parameter will never trigger.
> >
> > Check for param type being a flag first (flag is the only type that doe=
s
> > not have a parameter) and report "Missing value" if the parameter is
> > mandatory.
> >
> > Tested with gfs2's "quota" option, which is currently the only user of
> > fs_param_v_optional.
>
> It's not clear to me what the bug is here. My tests with the quota
> option are giving expected results. Perhaps I missed a case?

fsopen-test-2: fsconfig(3, FSCONFIG_SET_FLAG, "quota", NULL, 0):
Invalid argument
fsopen-test-2: context log: <e gfs2: Bad value for 'quota'>

kernel: 5.4.0-08836-g81b6b96475ac

Thanks,
Miklos

