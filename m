Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B978814AD8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 02:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgA1B2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 20:28:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33478 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgA1B2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:28:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so13017134lji.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 17:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyg3NKEp2bxr484Sg68cndy6raZFMZTA4yF4ZhQs6xQ=;
        b=ZwZCZIO0IYyYHGyUd4fQxgAHJdpemFwJyBRh1bLDPf/Bg4kuctvr+23k1ufcDXh+rO
         YhacjuLMqf6owAn9magtEfwyFneJosD23UCjAsMEY8OCj2mNNtkv03tLOEY6YV9uAz0P
         Mof+NMLsFwiPZXulWXN6n9oGlUwtjLuKeL85U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyg3NKEp2bxr484Sg68cndy6raZFMZTA4yF4ZhQs6xQ=;
        b=BFwA/78Zv9z9fNfLIX/rxQTc/S+BaJI1h3QikVJQRF8RJc04W/WsH1d8zbBKxq84MC
         R/91Y3cDdMzeWGBvESLPkwrw2GH3Uz0luMYxB/XC+MGROkoMj9fERe4OE0uU/dGdHfPv
         SK0Vn1OyiY4T1Uitg/j7E5LGN8WPvwbD279m22LsLgmllORf/+VFFZH/bhBfBYMozMR4
         XF7JbPVjsqNTt7t/3tXRIKXiDZ3wYuFHhuc5xuVS6POjP6lRpfx6aYBIS+QPNEJBkE15
         Z9Iv+mosY3jbe0cOS4BxF6o7v/phh91kgbHfXJtpSbOUDZSvO5IyV5WO+KUr47TY2rGh
         3BYw==
X-Gm-Message-State: APjAAAUbDjeAy4gOeuUAU/EV6qdZ8nMF7zanIaf6YGnUAELS8iviUB9Q
        jtZv38ZdXHpjFOIdiQ3jyWaBMHTsCSA=
X-Google-Smtp-Source: APXvYqya6oZU1+VsIE3B7peB/vQ8wtnBpAzyuIZrRynaX2m81+GmmwXPld6oV6LrP+Z6b157d/mc/g==
X-Received: by 2002:a05:651c:38b:: with SMTP id e11mr11441933ljp.259.1580174921332;
        Mon, 27 Jan 2020 17:28:41 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c22sm8834626lfc.93.2020.01.27.17.28.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 17:28:40 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id y19so7776831lfl.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 17:28:40 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr825368lfb.31.1580174919818;
 Mon, 27 Jan 2020 17:28:39 -0800 (PST)
MIME-Version: 1.0
References: <3021e46f-d30b-f6c5-b1fc-81206a7d034b@web.de> <BYAPR04MB5816FB9844937D8A86B52F8DE70A0@BYAPR04MB5816.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5816FB9844937D8A86B52F8DE70A0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jan 2020 17:28:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whHZzyaRKu5WXTE7_mPaQPf-E-r=cZ+8YGVK5RPbzjt1g@mail.gmail.com>
Message-ID: <CAHk-=whHZzyaRKu5WXTE7_mPaQPf-E-r=cZ+8YGVK5RPbzjt1g@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 5:26 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> Yes, good catch. Furthermore, since this array is used only in
> zonefs_create_zgroup(), I moved its declaration on-stack in that function.

What?

Making it _local_ to that function makes sense, but not on stack.
Please keep it "static const char *[]" so that it isn't copied onto
the stack.

               Linus
