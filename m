Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96587CC6A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 01:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfJDXp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 19:45:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40239 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDXpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:45:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so7496238edm.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=emgQa1s1giOkhpA6eB1UZEqK2eshGrQDl1+TYsmBoNk=;
        b=goB+pEocgz9Wm75oToyjTR8v19aH5+epzLwffVC6PJBUi1LWGoK4lQK8D9uARvMN6a
         c2U+3rcyU3Vw3xLks90bKDdJClP9TIieSP5OL1k3Q/ivZUdYWlETdV88V9Q/aU+dJ0gk
         fPEhhR2zduylRdA6vpYGVRt+8eE+ALFv3jWzf0b8V+8Tz/5dnnzS6/nsrDU+G/gIMDdm
         4Hd9T6JtC0lXA/6HHkDlH6qBNlXqGrpAOTBTK15+jyl2WEkHn4iaGtAUXvezfM7OaUx0
         RJELX3/kxATKiW0Isf9+9EAP73wkJQVLF0mtQ7r42iY+G1vYolnq2jP9SWCtbD1Itco9
         WToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=emgQa1s1giOkhpA6eB1UZEqK2eshGrQDl1+TYsmBoNk=;
        b=pXfbka6sh3FNoFCQ4PyaN2bVd80Xe+EEjnwKtrleCltIV1HYj/cB/OXq8Usx1uFN4b
         32vhhj6FhoGsbvEhysB1nR7uO+kVmr26xuuq+QjjpkIquVt4L0wzLMttEvUVGaujM591
         IjjwBcvY1m80YVJ4aAJ0VY4LpgJERUtH6pBBhABtzmhkT6LjzjDsDP36MEYQPlviP6/G
         RA3BEk0GYLxezvR8U5q0AG0glyclGazb2IIbGISryEQzh/9FO1oY6gFADuKXYP4pkt+e
         ZsFjnblX71axyPNfjzm0KBNOJZkg3gT+454wPB8p2pYsEIA735chkKYthNnB0cJY8SRV
         ACIA==
X-Gm-Message-State: APjAAAWS8mHZLsMjnursNktwvMzvg0YfDox3n9ZqGuXBoV0XWftzZv3c
        NB1q6hUxfuMVfKp8InyTnZxXDVI=
X-Google-Smtp-Source: APXvYqyDolv90emJxkP12Imke9U6MFVwK/y89nXrU3WENS7UVHi37MTJYVUJ+wgvghduvyR9hgCAVw==
X-Received: by 2002:a17:906:4990:: with SMTP id p16mr14979693eju.9.1570232724182;
        Fri, 04 Oct 2019 16:45:24 -0700 (PDT)
Received: from avx2 ([46.53.250.131])
        by smtp.gmail.com with ESMTPSA id dt4sm796313ejb.45.2019.10.04.16.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 16:45:23 -0700 (PDT)
Date:   Sat, 5 Oct 2019 02:45:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: delete useless "len" variable
Message-ID: <20191004234521.GA30246@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pointer to next '/' encodes length of path element and next start position.
Subtraction and increment are redundant.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -163,7 +163,6 @@ static int __xlate_proc_name(const char *name, struct proc_dir_entry **ret,
 {
 	const char     		*cp = name, *next;
 	struct proc_dir_entry	*de;
-	unsigned int		len;
 
 	de = *ret;
 	if (!de)
@@ -174,13 +173,12 @@ static int __xlate_proc_name(const char *name, struct proc_dir_entry **ret,
 		if (!next)
 			break;
 
-		len = next - cp;
-		de = pde_subdir_find(de, cp, len);
+		de = pde_subdir_find(de, cp, next - cp);
 		if (!de) {
 			WARN(1, "name '%s'\n", name);
 			return -ENOENT;
 		}
-		cp += len + 1;
+		cp = next + 1;
 	}
 	*residual = cp;
 	*ret = de;
