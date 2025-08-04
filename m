Return-Path: <linux-fsdevel+bounces-56695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59033B1AB1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 00:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C2717013C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC18D291891;
	Mon,  4 Aug 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB6h0nfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFC23B0;
	Mon,  4 Aug 2025 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348232; cv=none; b=RekKPov8w5zSchGzqTOOO1j3vhMZ5Q/mLyZ1BhEvkudUTlcAokw0nCnP0221BZMJsm20WlaFG5M2WaTVbWdSvSAB1ueQ9rJqAhfhgLIvtmb21y7/4nl9QuCknsAehd4W8BbxEXrDWb+12l8PbArvEamNlzMfvEGtIFkRB2k5Ao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348232; c=relaxed/simple;
	bh=9oKXtOqT/7ZhZjt2DGH7GRuX05WLiaM2Ad5p+ORGuJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rzJoBBz4VTEKOICpAE91gWkzsUlxYTjufWSRs+k+XBmzSev4e9SS0x5aSAeZm/AT5GQ6Sq0NQelLX6786xCiLURgoMhL6e8NatI75jrv35/hiCXiS95wQD9qbtANrW071InW4OsgX27R56HRfvUcv1mucWUU3tT9ICC7GMyu7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB6h0nfE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so7770768a12.2;
        Mon, 04 Aug 2025 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754348229; x=1754953029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr2agJDZBQmVW9FUU147Ibs/lRl/y87H55FoFWi7jBs=;
        b=bB6h0nfEIM4xmOJP6F2z5UYVCUO6OYZfcb4pP8SAQk9SymskNG7MAn4JcCV7G3TrMD
         tJ5hT8RHL7njTXsIcnM7AO9i064oLckuUqzIQd5NRuuCV3y8++ZJ0WWz6yr2aPU3y4EP
         KcE43UHfDhI+lD+67KZUpd8ZXmJLdtI8VfBuczwLw5ZPyRUW6algPMDvc6M/qHW7PiHj
         /0eRXUMwueqyIINWNBM8LtauvfaQerSAZDcfNPcFBqCef2LLT0EgMGhZV0aLlxXLmeJT
         XgRIv0bTDjmshZm4i0KFjBLlz2/30x3e3TgxB4+WdRqMD1hnEVLCh8gcxJoqY6fX/MHj
         cCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754348229; x=1754953029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr2agJDZBQmVW9FUU147Ibs/lRl/y87H55FoFWi7jBs=;
        b=HLv/RQBfxzIgb5dpy+hO23aIes31fa2HGLgIg7wMWTQR8NTAHMnwujrtKFfR+wLP5W
         6HKJS12LAqn4vDXd1bJW1UI1hrDFPis/EXAnkELGhus6Fvz+pAzBHzP3Iz/0DQkfwfYQ
         QghpQZv3tebUzOcugW5aHeDNcmE7vY5ooMEj/tOKHqgQcyum6ApKtOiP/KjUko6vK9F5
         GiodaXkx4nlt1EBCgrHRb/QEnXpSIT1Mk+2T4vgNakagHkcyUQkui0wMAReJCczlJeFe
         QX3z/D+tB5iw2FOONf03u+crev09AYV10eNjfMB7GCGjR7op3WSUaZ8Q7JG9vlV6cCuz
         GMFg==
X-Forwarded-Encrypted: i=1; AJvYcCV4k5ZiWi+7D2MnzNF26mCAYK4lzEThJUXXWQ5V/JWNQZhchBowFVYiEfsdZ21tiAtdeHcFIfVld2M9q/Pb@vger.kernel.org, AJvYcCVjPOII+8ZVrbTYRqjUGy/0vNVNzlssRmmztQn7yEZx6LL8Mo7g1SAChLPW2x+snk8P0vk4SaBtkbkmNNBQ@vger.kernel.org, AJvYcCVkMOe1Id8kVzWPMDO5aCrfRLLQnGCC3y5DjrjwasQ4beIzPyrAq+su1kuCu9JjleOXB56oksSy3tOY6f4ny8II@vger.kernel.org
X-Gm-Message-State: AOJu0YyBF7rY8nh4p2ktGxo4qb0hD6OkevJUAwez+fdza1xzDtaFF6QP
	Xlv24Y30iasLqgmX7oM5zWeWy+8XBzY4G8OPWeee3ltLV4T/CevJnGhG
X-Gm-Gg: ASbGncs5XnAp8TxKFR/d0HK9GsHUSUjIF8KniqfE94KeH3W+95PE2EmZCtkgGCpf18/
	VESenfSQvqwpvB0VWTzR7OujXjSOwS0vvWKF09IOiHL5unJsrtvqsm/pTDAc2qvRcE236lG2rFc
	ICB7kKbYkPjrj59nsbWjgGFrUpzPWGaaw3nVo7GBbx5ENSf0ot5jUh7lnz9V4haUUK4OJjlbBoZ
	qofDazdEf5FevjvlVrE8s34TIP0mp1VmuJEtTIm+Wo3080mk7BKiVX1aEESBTySnf7EgG9DTQKm
	C0NNvjf8nThIFBrAxoFiLaZRT5zLiOBUeSIeRnwouAIqxZVxygA6/Rsf9n5xauByPkp4ETWwkxZ
	X3FndmiMTJvP04wI=
X-Google-Smtp-Source: AGHT+IHifYLUrYrD0a96WpNHE6XmhRmOU49DTRryYgiHod6ocIc9uDWzMDgfTzrhxCU7Y8NuvXV8vw==
X-Received: by 2002:a17:907:6d14:b0:ae3:cc60:8ce7 with SMTP id a640c23a62f3a-af94001fea2mr1132451866b.19.1754348228543;
        Mon, 04 Aug 2025 15:57:08 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b77sm798173366b.51.2025.08.04.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:57:08 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM),
	linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH v2] selftests/proc: Fix string literal warning in proc-maps-race.c
Date: Tue,  5 Aug 2025 00:56:14 +0200
Message-ID: <20250804225633.841777-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change resolves non literal string format warning invoked
for proc-maps-race.c while compiling.

proc-maps-race.c:205:17: warning: format not a string literal and no format arguments [-Wformat-security]
 205 |                 printf(text);
     |                 ^~~~~~
proc-maps-race.c:209:17: warning: format not a string literal and no format arguments [-Wformat-security]
 209 |                 printf(text);
     |                 ^~~~~~
proc-maps-race.c: In function ‘print_last_lines’:
proc-maps-race.c:224:9: warning: format not a string literal and no format arguments [-Wformat-security]
 224 |         printf(start);
     |         ^~~~~~

Added string format specifier %s for the printf calls
in both print_first_lines() and print_last_lines() thus
resolving the warnings invoked.

The test executes fine after this change thus causing no
affect to the functional behavior of the test.


Fixes: aadc099c480f ("selftests/proc: add verbose mode for /proc/pid/maps tearing tests")
Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---

Changes since v1:
- Added Fixes tag
- Included Acked-by Suren Baghdasaryan
https://lore.kernel.org/all/CAHCkknoxpKV80-S3jByY1xnRXd1Pr=v=D2a0ZcgnY0-Hnya56Q@mail.gmail.com/

 tools/testing/selftests/proc/proc-maps-race.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 66773685a047..94bba4553130 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -202,11 +202,11 @@ static void print_first_lines(char *text, int nr)
 		int offs = end - text;
 
 		text[offs] = '\0';
-		printf(text);
+		printf("%s", text);
 		text[offs] = '\n';
 		printf("\n");
 	} else {
-		printf(text);
+		printf("%s", text);
 	}
 }
 
@@ -221,7 +221,7 @@ static void print_last_lines(char *text, int nr)
 		nr--;
 		start--;
 	}
-	printf(start);
+	printf("%s", start);
 }
 
 static void print_boundaries(const char *title, FIXTURE_DATA(proc_maps_race) *self)
-- 
2.43.0


